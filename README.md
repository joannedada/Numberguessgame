---

# **NumberGuessGame**
A simple **Java web application** that lets users guess a random number. This project is built using **Jenkins, Docker, Nexus, and Tomcat**, with **CI/CD automation**.

## **Features**
✅ Random number guessing game  
✅ Fully automated **CI/CD pipeline**  
✅ **SonarQube integration** for code quality analysis  
✅ **Docker & Nexus** for containerization and image management  
✅ **Trivy** for security scanning  

## **Project Structure**
```
NumberGuessGame/
├── src/main/java/com/studentapp/NumberGuessServlet.java
├── src/main/webapp/WEB-INF/web.xml
├── src/main/webapp/index.jsp
├── pom.xml (Maven Build File)
├── Jenkinsfile (Pipeline Automation)
├── Dockerfile (Containerization)
├── .gitignore
├── README.md
```

## **Setup Instructions**
### **Prerequisites**
- Install **Java 17** and **Maven**  
- Install **Docker & Docker Compose**  
- Install **Jenkins** on an **EC2 instance**  
- Install **SonarQube** and **Nexus Repository**  

### **Clone the Repository**
```sh
git clone https://github.com/Elijahleke/NumberGuessGame.git
cd NumberGuessGame
```

### **Build & Run the Application**
```sh
mvn clean package
```
Deploy the generated **WAR file** to **Tomcat**.

### **Run the CI/CD Pipeline in Jenkins**
- Push changes to GitHub → Jenkins automatically triggers build & deployment.

### **Access the Application**
After deployment, open:  
`http://<EC2-IP>:8080/NumberGuessGame`

---

## **CI/CD Pipeline Workflow**
**Code push to GitHub → Jenkins triggers build**  
**Maven compiles, tests, and packages the app**  
**SonarQube scans for code quality**  
**Docker builds an image and pushes it to Nexus**  
**Trivy scans for vulnerabilities**  
**WAR file is deployed to Tomcat**  

---

## **Monitoring & Logging**
- **Jenkins Console Output** for debugging  
- **Nexus UI** to check Docker image versions  
- **Tomcat Manager** to manage deployments  

---

