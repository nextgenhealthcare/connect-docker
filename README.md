# Supported tags and respective Dockerfile links
* 3.8.0, latest

# Quick reference
#### Where to get help:
[Connect Forum](http://www.mirthcorp.com/community/forums/),
[Slack Channel](https://mirthconnect.slack.com/),
[Slack Registration](https://mirthconnect.herokuapp.com)
#### Where to file issues:  
[Issue Tracker (JIRA)](http://www.mirthcorp.com/community/issues)
#### Maintained by: 
NextGen Connect team
#### Source of this description: 
link to GitHub page

# What is NextGen Connect (formerly Mirth Connect)
For more information and related downloads for NextGen Connect and other NextGen products, please visit:

https://www.nextgen.com/products-and-services/NextGen-Connect-Integration-Engine-Downloads

![logo](https://qsinextgen.sharepoint.com/:i:/r/sites/compass-marketingandcommunications/Shared%20Documents/Logos/NextGen%20Logos/NG_Logo_Final_RGB_72.png?csf=1&e=pXwKd7)

##### The NextGen Solutions Mission
NextGen Solutions help many of the nation&apos;s largest, most respected healthcare entities streamline their care-management processes to satisfy the demands of a regulatory, competitive healthcare industry. With Mirth Solutions, NextGen Healthcare&apos;s goal is to provide the healthcare community with a secure, efficient, cost-effective means of sharing health information. The natural product of this aim is a family of applications &mdash; which includes NextGen Connect &mdash; flexible enough to manage patient information, from small practices to large HIEs, so our clients and users can work confidently and effectively within the healthcare-delivery system.
##### About NextGen Connect
Like an interpreter who translates foreign languages into the one you understand, NextGen Connect translates message standards into the one your system understands. Whenever a &quot;foreign&quot; system sends you a message, NextGen Connect&apos;s integration capabilities expedite the following:
- Filtering &mdash; NextGen Connect reads message parameters and passes the message to or stops it on its way to the transformation stage.
- Transformation &mdash; NextGen Connect converts the incoming message standard to another standard (e.g., HL7 to XML).
- Extraction &mdash; NextGen Connect can &quot;pull&quot; data from and &quot;push&quot; data to a database.
- Routing &mdash; NextGen Connect makes sure messages arrive at their assigned destinations.

# How to use this image
## Start a Connect instance
Quickly start Connect using embedded Derby database and all default configurations 

` $docker run --name myconnectinstance -d connect:latest`

... where ...

## Custom Configuration
### using *Environment Variables*

### using *docker-compose*

### using secret

## Environment Variables 

# License
View license information for the software contained in this image
NextGen Connect is released under the [Mozilla Public License version 1.1](https://www.mozilla.org/en-US/MPL/1.1/ "Mozilla Public License version 1.1"). You can find a copy of the license in `server/docs/LICENSE.txt`.
All licensing information regarding third-party libraries is located in the `server/docs/thirdparty` folder.
