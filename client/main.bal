import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Create an HTTP client to connect to the server
    http:Client clientEP = check new ("http://localhost:9000/pdu");

    // Define a new programme to be added
    Programme newProgramme = {
        programme_code: "08BCMS",
        NqfLevel: LEVEL_8,
        faculty: "Computing and Informatics",
        department_name: "Software Development",
        programme_title: "Bachelor of Computer Science",
        registration_date: "01-09-2024",
        courses: [
            {course_code: "CS201", course_name: "Advanced Programming"},
            {course_code: "CS202", course_name: "Operating Systems"}
        ]
    };

    // Send a POST request to add the new programme
    http:Response|http:ClientError response = clientEP->post("/programmes", newProgramme);
    if (response is http:Response) {
        // Print success message with the response payload
        io:println("Programme added successfully: ", response.getJsonPayload());
    } else {
        // Print error message with the response message
        io:println("Failed to add programme: ", response.message());
    }

    // Define the programme code to be deleted
    string programme_code = "08BCMS";

    // Send a DELETE request to delete the programme
    http:Response|http:ClientError deleteResponse = clientEP->delete("/programme/" + programme_code);
    if (deleteResponse is http:Response) {
        if (deleteResponse.statusCode == http:STATUS_NO_CONTENT) {
            io:println("Programme deleted successfully.");
        } else if (deleteResponse.statusCode == http:STATUS_NOT_FOUND) {
            io:println("Programme not found.");
        } else {
            io:println("Failed to delete the programme. Status code: ", deleteResponse.statusCode);
        }
    } else {
        io:println("Failed to delete programme: ", deleteResponse.message());
    }
    // Retrieve all programs
    error? retrieveError = retrieveAllPrograms(clientEP);
    if (retrieveError is error) {
        io:println("Error retrieving programs: ", retrieveError.message());
    }

    // Retrieve programme title using programme_code
    string programmeCodeToRetrieve = "07BCMS";
    error? titleError = retrieveProgrammeTitle(clientEP, programmeCodeToRetrieve);
    if (titleError is error) {
        io:println("Error retrieving programme title: ", titleError.message());
    }

    // Retrieve old programmes
    error? oldProgrammesError = retrieveOldProgrammes(clientEP);
    if (oldProgrammesError is error) {
        io:println("Error retrieving old programmes: ", oldProgrammesError.message());
    }
}
// Function to retrieve all programs
function retrieveAllPrograms(http:Client clientEP) returns error? {
    // Send a GET request to retrieve all programs
    http:Response response = check clientEP->get("/programs");

    // Check the status code of the response
    if (response.statusCode == 200) {
        // Parse the JSON response to an array of Programmes
        json jsonResponse = check response.getJsonPayload();
        Programme[] programs = check jsonResponse.fromJsonWithType();

        // Print the list of programs
        io:println("List of Programs: ", programs.toString());
    } else {
        io:println("Failed to retrieve programs. Status code: ", response.statusCode);
    }
}

// Function to retrieve programme title using programme_code
function retrieveProgrammeTitle(http:Client clientEP, string programme_code) returns error? {
    // Send a GET request to retrieve the programme title
    http:Response response = check clientEP->get("/programme/" + programme_code);

    // Check the status code of the response
    if (response.statusCode == 200) {
        // Parse the JSON response to an array of strings
        json jsonResponse = check response.getJsonPayload();
        string[] programmeTitles = check jsonResponse.fromJsonWithType();

        // Print the programme title
        io:println("Programme Title: ", programmeTitles.toString());
    } else {
        io:println("Failed to retrieve programme title. Status code: ", response.statusCode);
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
