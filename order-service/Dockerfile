FROM maven:3.9.3-eclipse-temurin-17

WORKDIR /app

# 1️⃣ Copy only pom.xml first
COPY pom.xml .

# 2️⃣ Download dependencies (caches them if pom.xml didn't change)
RUN mvn dependency:go-offline

# 3️⃣ Copy the source code
COPY src ./src

# 4️⃣ Build the project
RUN mvn clean package -DskipTests

# 5️⃣ Run the JAR
CMD ["java", "-jar", "app.jar"]
