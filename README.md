# ksl-sap-shipments
Shipment tracking for SAP ABAP Table VTTK (Shipment Header) at https://www.sapdatasheet.org/abap/tabl/vttk.html

Repository contents:

/infra - Terraform creats a three-tiered architecture in Azure, consisting of a PostgreSQL database, a Node.js back-end, and a React & Next.js front-end. This architecture is deployed as a Docker container on an Azure App Service. Alternatively, Terraform could create a stack in AWS using MySQL, Node.js, and React & Next.js, all deployed as Docker containers on, for instance, Kubernetes.

/app – the front-end and back-end of the application. The data presented in the front-end is automatically updated in real-time. To achieve this, the front-end uses SWR, which is a data fetching library that is based on the HTTP standard RFC 5861, to poll the API provided by the back-end. If the real-time requirement is stricter than 10 seconds, then WebSocket is added alongside SWR on a case-by-case basis.
