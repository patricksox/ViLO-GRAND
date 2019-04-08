// Entity => Resource

MATCH (n: Entity)
WHERE n.title IS NULL
SET n.title = n.Label
SET n.institution = null
SET n.description = null
REMOVE n.Label
REMOVE n:Entity
SET n:Resource

// Concept => Concept

MATCH (n: Concept)
WHERE n.title IS NULL
SET n.title = n.Label
REMOVE n.Label

// Construct => Concept

MATCH (n: Construct)
WHERE n.title IS NULL
SET n.title = n.Label
REMOVE n.Label
REMOVE n:Construct
SET n:Concept

// Theme => Concept

MATCH (n: Theme)
WHERE n.title IS NULL
SET n.title = n.Name
REMOVE n.Name
REMOVE n:Theme
SET n:Concept

// Example AND Error => Example

MATCH (n)
WHERE (n:Example OR n:Error) AND n.body IS NULL
SET n.body = n.Body
SET n.explanation = n.Explanation
REMOVE n.Body
REMOVE n.Explanation
REMOVE n.Label

// Discussion => Description

MATCH (n: Discussion)
WHERE n.body IS NULL AND NOT n.Label = "null" AND n.Label IS NOT null
SET n.body = n.Label + ": " + n.Body
REMOVE n.Body
REMOVE n.Label
REMOVE n:Discussion
SET n:Description

MATCH (n: Discussion)
WHERE n.body IS NULL AND (n.Label IS null OR n.Label = "null")
SET n.body = n.Body
REMOVE n.Body
REMOVE n.Label
REMOVE n:Discussion
SET n:Description

// Resource => Link

MATCH (n: Resource)
WHERE n.title IS NULL AND n.body IS NULL
SET n.body = n.Body
REMOVE n.Body
REMOVE n.Label
REMOVE n:Resource
SET n:Link
Module => Module

MATCH (n: Module)
SET n.code = n.ModuleCode
REMOVE n.ModuleCode
Lecture => Lecture

MATCH (n: Lecture)
SET n.number = n.Number
REMOVE n.Number
Migrating relations
CSError => EXPLAINS

MATCH (a)-[oldRelation:CSError]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
CSExample => EXPLAINS

MATCH (a)-[oldRelation:CSExample]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
CoreError => EXPLAINS

MATCH (a)-[oldRelation:CoreError]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
CoreExample => EXPLAINS

MATCH (a)-[oldRelation:CoreExample]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
HasCode => EXPLAINS

MATCH (a)-[oldRelation:HasCode]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
MTError => EXPLAINS

MATCH (a)-[oldRelation:MTError]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
MTExample => EXPLAINS

MATCH (a)-[oldRelation:MTExample]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
appear => EXPLAINS

MATCH (a)-[oldRelation:appear]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
contain => EXPLAINS

MATCH (a)-[oldRelation:contain]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
explain => EXPLAINS

MATCH (a)-[oldRelation:explain]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
produce => EXPLAINS

MATCH (a)-[oldRelation:produce]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
require => EXPLAINS

MATCH (a)-[oldRelation:require]->(b)
CREATE (a)-[newRelation:EXPLAINS]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
Related => TEACHES

MATCH (a)-[oldRelation:Related]->(b)
CREATE (a)-[newRelation:TEACHES]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
exRelated => TEACHES

MATCH (a)-[oldRelation:exRelated]->(b)
CREATE (a)-[newRelation:TEACHES]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
teaches => TEACHES

MATCH (a)-[oldRelation:teaches]->(b)
CREATE (a)-[newRelation:TEACHES]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation
Change out any ()-[:EXPLAINS]->(CONCEPT) relations to [:TEACHES]

MATCH (a)-[oldRelation:EXPLAINS]->(b:Concept)
CREATE (a)-[newRelation:TEACHES]->(b)
SET newRelation = oldRelation
WITH oldRelation
DELETE oldRelation