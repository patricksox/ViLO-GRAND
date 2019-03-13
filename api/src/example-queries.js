/**
 * Example queries & mutations to use this API server
 * Created using the examples here:
 * https://gist.github.com/deptno/e76d2550cfc0d374899c3e6efe5d7831
 */

import gql from 'graphql-tag';

/**
 * Get a resource with (up to) 6 levels of nested child concepts
 * Note that *id* is a custom <optional> identifier, which is used in our seed DB script
 * In general, you want to use _id to reference nodes
 * (because _id is automatically generated by Neo4j and guaranteed to be unique)
 */
const RESOURCE_QUERY = gql`
  query getResource {
    Resource(_id: 1) {
      ...resource
    }
  }
`;

/**
 * Get a concept with (up to) 5 levels of nested child concepts
 */
const CONCEPT_QUERY = gql`
  query getConcept {
    Concept(_id: 2) {
      ...concept
    }
  }
`;

const RESOURCE_FRAGMENT = gql`
  fragment resource on Resource {
    _id
    title
    institution
    description
    concepts {
      ...concept
    }
  }
`;

const CONCEPT_FRAGMENT = gql`
  fragment concept on Concept {
    ...conceptWithoutChildren
    concepts {
      ...conceptWithoutChildren
      concepts {
        ...conceptWithoutChildren
        concepts {
          ...conceptWithoutChildren
          concepts {
            ...conceptWithoutChildren
            concepts {
              ...conceptWithoutChildren
            }
          }
        }
      }
    }
  }

  fragment conceptWithoutChildren on Concept {
    _id
    title
    # resource { title }
    # visualType
  }
`;
