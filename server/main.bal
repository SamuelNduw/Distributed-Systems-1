import ballerina/http;
import ballerina/time;

// Define the service at the base path /pdu
service /pdu on new http:Listener(9000) {

    // Resource to retrieve the list of all programs
    resource function get programs(http:Caller caller, http:Request req) returns error? {
        // Convert the table to an array to return as JSON
        Programme[] programs = programme_table.toArray();

        // Send the response with the list of programs
        check caller->respond(programs);
    }


    // Resource function to handle POST requests to add new programmes
    resource function post programmes(http:Caller caller, http:Request req) returns error? {
        Programme newProgramme;
        // Get the JSON payload from the request
        var result = req.getJsonPayload();
        if (result is json) {
            // Convert the JSON payload to a Programme record
            newProgramme = check result.cloneWithType(Programme);
            // Check if the programme code already exists in the table
            if programme_table.hasKey(newProgramme.programme_code) {
                // Create a response with a 409 Conflict status code
                http:Response conflictResponse = new;
                conflictResponse.statusCode = http:STATUS_CONFLICT;
                conflictResponse.setPayload({errmsg: "Programme code already exists"});
                // Respond with the conflict error
                check caller->respond(conflictResponse);
            } else {
                // Add the new programme to the table
                programme_table.add(newProgramme);
                // Respond with the added programme
                check caller->respond(newProgramme);
            }
        } else {
            // Create a response with a 400 Bad Request status code
            http:Response badRequestResponse = new;
            badRequestResponse.statusCode = http:STATUS_BAD_REQUEST;
            // Respond with the bad request error
            check caller->respond(badRequestResponse);
        }
    }


    // Resource function to handle DELETE requests
    map<Programme> programme = {};
    resource function delete programmeCode(string programmeCode, http:Caller caller) returns error?{
        http:Response response = new();
        http:Response notFoundResponse = new();
        
 // Check if the programme code exists in the table
        if !programme_table.hasKey(programmeCode) {
            // Create a response with a 404 Not Found status code
            notFoundResponse.statusCode = http:STATUS_NOT_FOUND;
            notFoundResponse.setPayload({errmsg: "Programme not found"});
            // Respond with the not found error
            check caller->respond(notFoundResponse);
        } else {
            // Remove the programme from the table
             Programme? removedProgramme = programme_table.remove(programmeCode);
            // Create a response with a 204 No Content status code
            http:Response noContentResponse = new();
            noContentResponse.statusCode = http:STATUS_NO_CONTENT;
            // Respond with the no content status
            check caller->respond(noContentResponse);
        }
    }

    // Resource to Retrieve programme title using the programme_code as a parameter
    resource function get programme/[string programme_code]() returns string[]|error {
        string[] programmes = [];
        
        foreach var programme in programme_table {
            if (programme.programme_code == programme_code) {
                programmes.push(programme.programme_title);
            }
        }

        return programmes;
    };
    // An API to get programmes that are for review (registration_date greater than or equal to 5 years)
    resource function get oldProgrammes() returns Programme[]|error {
        Programme[] oldProgrammes = [];
        time:Utc currentDate = time:utcNow();
        
        foreach Programme programme in programme_table {
            do {
                time:Utc registrationDate = check time:utcFromString(programme.registration_date);
                decimal yearsDiff = <decimal>time:utcDiffSeconds(currentDate, registrationDate) / (365.25 * 24 * 60 * 60);
                if yearsDiff >= 5d {
                    oldProgrammes.push(programme);
                }
            } on fail error e {
                return error("Error processing date for programme: " + programme.programme_code, e);
            }
        }
        
        return oldProgrammes;
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

// Initialize the programme_table with a sample programme
public final table<Programme> key(programme_code) programme_table = table [
    {programme_code: "07BCMS", NqfLevel: LEVEL_8, faculty: "Computing and Informatics", department_name:"Software Development", programme_title: "Bachelor of Computer Science", registration_date: "2021-09-01T00:00:00Z", courses: [{course_code: "CS101", course_name: "Introduction to Computer Science"},
            {course_code: "CS102", course_name: "Data Structures and Algorithms"},
            {course_code: "CS103", course_name: "Database Management Systems"}]},
    {programme_code: "10BENG", NqfLevel: LEVEL_8, faculty: "Engineering", department_name:"Electrical Engineering", programme_title: "Bachelor of Engineering", registration_date: "2018-09-01T00:00:00Z", courses: [{course_code: "EE101", course_name: "Introduction to Electrical Engineering"},
            {course_code: "EE102", course_name: "Circuit Analysis"},
            {course_code: "EE103", course_name: "Digital Systems"}]}
];

// Define the ConflictingProgrammeCodeError record type
public type ConflictingProgrammeCodeError record {|
    *http:Conflict;
    ErrorMsg body;
|};

// Define the ErrorMsg record type
public type ErrorMsg record {|
    string errmsg;
|};