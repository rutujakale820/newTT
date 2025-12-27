Timetabler Full Skeleton (OptaPlanner-ready)

Structure:
- config, controllers, dto, entities, events, exceptions, listeners, repositories, services, util, optaplanner

This is a skeleton to accelerate your development. Fill in repositories and service logic,
wire OptaPlanner solver with a TimetableSolution class, and implement DTOs and controllers.

To build:
mvn package

Run (after configuring DB and migrating schema):
java -jar target/timetabler-full-0.0.1-SNAPSHOT.jar
