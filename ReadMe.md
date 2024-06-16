# Karate API Automation

- A PoC project of API Automation test with the Karate framework
- This project uses the endpoints from Realworld REST APIs

## Set up

1. Clone the code repository
2. Open the project in Visual Studio
3. Run the tests: `mvn clean test -Dkarate.options="--tags @smoke" -Dkarate.env="dev"`
4. Checkout the cucumber report at target/cucumber-html-reports/overview-features.html

## Feature Keywords

- Hands-on for GET & POST methods. Do the assertions (match & fuzzy match) to verify the response status code, response field values, and Schema Validation.
- Environment handler + Data generation
- Run tests with Docker
- Visualize the test results in Cucumber Report
<img width="900" alt="Screenshot 2024-06-16 at 11 04 14" src="https://github.com/lengochoangminh/Karate-API-Test-PoC/assets/29770042/132dce5c-75f4-4f45-b1d7-6a12fd40fcac">
