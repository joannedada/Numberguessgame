# Use OpenJDK 17 as the base image
FROM openjdk:17

# Install Maven using MicroDNF
RUN microdnf install -y maven && microdnf clean all

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the application
RUN mvn clean package

# Expose the port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "target/your-app.jar"]
