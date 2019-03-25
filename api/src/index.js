/**
 * Import libraries to run the Apollo GraphQL server and connect to neo4k
 */
import {
  ApolloServer,
  gql,
  makeExecutableSchema,
  addMockFunctionsToSchema,
} from 'apollo-server';
import { v1 as neo4j } from 'neo4j-driver';
import { augmentSchema } from 'neo4j-graphql-js';

// Import our GraphQL type definitions and resolver functions
import { typeDefs, resolvers } from './schema/graphql-schema';

/**
 * Import all environment variables from the .env file
 * (the .env file isn't commited to version control, so make sure you create one using the example.env file)
 */
import dotenv from 'dotenv';
dotenv.config();

/**
 * Generate a GraphQLSchema instance using our type definitions (like `type Resouce {...}`)
 * And our resolver functions (which tell the schema how to resolve queries and mutations)
 */
let schema = makeExecutableSchema({
  typeDefs,
  resolvers,
});

/**
 * addMockFunctionsToSchema enables the schema to serve mock data to the client
 * which is super useful for testing the back-end server without setting up
 * a Neo4j database with seed data. Learn more about it here:
 * https://www.apollographql.com/docs/graphql-tools/mocking.html
 */
// addMockFunctionsToSchema({ schema });

/**
 * augmentSchema adds autogenerated mutations to our schema
 * which saves us from writing a lot of boilerplate code
 * note: it seems that augmentSchema doesn't work with addMockFunctionsToSchema
 */
schema = augmentSchema(schema);

/**
 * Connect to Neo4j database using credentials stored in environment variables
 * Or using the default credentials (for a local database)
 */
const driver = neo4j.driver(
  process.env.NEO4J_URI || 'bolt://localhost:7687',
  neo4j.auth.basic(
    process.env.NEO4J_USER || 'neo4j',
    process.env.NEO4J_PASSWORD || 'letmein'
  )
);

/**
 * Set up an Apollo server to serve our (augmented) GraphQL schema on top of the Neo4j database
 */
const server = new ApolloServer({
  context: { driver },
  schema: schema,
});

/**
 * Attempt to start our GraphQL server on the provided HOST address & PORT
 */
const PORT = process.env.GRAPHQL_LISTEN_PORT;
const HOST = process.env.GRAPHQL_HOST;
console.log(`🛫 Attempting to start API server on ${HOST}:${PORT} `);

server
  .listen(PORT, HOST)
  .then(({ url }) => console.log(`🚀 GraphQL API server ready at ${url}`))
  .catch(error => console.error('Unable to create GraphQL server :(', error));
