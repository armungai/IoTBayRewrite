# IoTBay Web Application
This is a JDP/Servlet based web application for an IoT product e-commerce platform called **IoTBay**.
The Application allows users to browse products, manage a cart, register/ login amd complete a checkout process with order and payment recording
## Features
- User registration at login
- Product catalouge with IoT devices
![Screenshot 2025-05-13 at 4.34.20 pm.png](../../../../var/folders/z3/658ztf1s2d7fnr0f7c1fk2b80000gn/T/TemporaryItems/NSIRD_screencaptureui_D4QPAS/Screenshot%202025-05-13%20at%204.34.20%E2%80%AFpm.png)- Shopping cart (session-based)
- Checkout with order and payment handling
- View Payment History & Sort/ Filter functionality
- View Order History & Sort/ Filter functionality
- Change personal details including:
  - shipping information
  - credit card information
  - personal details
## Tech Stack
- **FRONT END**: HTML, CSS
- **BACKEND**: Java Servlets, JSP
- **DATABASE**: SQLite
- **SERVER**: Apache Tomcat
- **Build Tool:** IntelliJ / Maven
## How to Run Locally (Instructions Provided for IntelliJ & MacOS)
1. Clone the repository and open in IntelliJ
2. In the top menu bar navigate to `Run -> Edit Configurations...`
3. Select `Add new run configuration`
![](Running-Photos/edit-config.png)
4. When prompted with `Add New Configuration` select `Smart Tomcat`
![](Running-Photos/options.png)
5. Leave all other options as default BUT change `Context Path:` to `'/'`
![](Running-Photos/options-2.png)
6. To run the application locally you will need to create a database in the `.SmartTomcat` directory and point the `DBConnector` class to it
   1. First locate the directory of your Smart Tomcat Server. On Mac Systems this is usually located `Users/*your-username*/.SmartTomcat/IoTBay/itswd-assignment-1-group-1/`
   2. In here create a new file called `IoTBay.db`
   3. Copy this absolute path (should look like `/Users/andrewmungai/.SmartTomcat/IoTBay/itswd-assignment-1-group-1/IotBay.db`)
   4. In the RHS menu-bar of IntelliJ select the database icon:
![](Running-Photos/db1.png)
   5. Select the `+` icon and select:

   ![](Running-Photos/db2.png)
   6. Locate the `IoTBay.db` on your system, when prompted select `SQLite` as the driver
   ![](Running-Photos/db4.png)
   7. Click `"Test Connection"` to check that everything works correctly
      ![](Running-Photos/db3.png)
   8. Navigate to `src/main/java/com/IoTBay/model/dao/DBConnector.java` and change line `17` to the file path found earlier. It should look like this:
   ```java
        String url = "jdbc:sqlite:/Users/armungai/.SmartTomcat/IoTBay/IoTDB.db";
7. Navigate to `src/Startup.sql`, right click and run the file. When prompted connect it to the database we just made
 
![](Running-Photos/db5.png)
8. Now simply run the project from the top menu bar:

![](Running-Photos/db7.png)

### Welcome to IoTBay!
   

