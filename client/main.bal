import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Create an HTTP client to connect to the server
    http:Client clientEP = check new ("http://localhost:9000/pdu");

    // Retrieve old programmes
    error? oldProgrammesError = retrieveOldProgrammes(clientEP);
    if (oldProgrammesError is error) {
        io:println("Error retrieving old programmes: ", oldProgrammesError.message());
    }
}
// Function to retrieve old programmes
function retrieveOldProgrammes(http:Client clientEP) returns error? {
    // Send a GET request to retrieve old programmes
    http:Response response = check clientEP->get("/oldProgrammes");

    // Check the status code of the response
    if (response.statusCode == 200) {
        // Parse the JSON response to an array of Programmes
        json jsonResponse = check response.getJsonPayload();
        Programme[] oldProgrammes = check jsonResponse.cloneWithType();
        // Print the list of old programmes
        io:println("Old Programmes: ", oldProgrammes.toString());
    } else {
        io:println("Failed to retrieve old programmes. Status code: ", response.statusCode);
    }
}  
// Define the Programme record type
public type Programme record {|
    readonly string programme_code;
    NQF NqfLevel;
    string faculty;
    string department_name;
    string programme_title;
    string registration_date;
    Course[] courses;
|};

// Define the NQF enum type
public enum NQF {
    LEVEL_5,
    LEVEL_6,
    LEVEL_7,
    LEVEL_8,
    LEVEL_9,
    LEVEL_10
};

// Define the Course record type
public type Course record {
    readonly string course_code;
    string course_name;
};