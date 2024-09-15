import ballerina/http;
import ballerina/time;

service /pdu on new http:Listener(9000) {
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

public type Programme record {|
    readonly string programme_code;
    NQF NqfLevel;
    string faculty;
    string department_name;
    string programme_title;
    string registration_date;
    Course[] courses;
|};

public enum NQF {
    LEVEL_5,
    LEVEL_6,
    LEVEL_7,
    LEVEL_8,
    LEVEL_9,
    LEVEL_10
};

public type Course record {
    readonly string course_code;
    string course_name;
};

public final table<Programme> key(programme_code) programme_table = table [
    {programme_code: "07BCMS", NqfLevel: LEVEL_8, faculty: "Computing and Informatics", department_name:"Software Development", programme_title: "Bachelor of Computer Science", registration_date: "2021-09-01T00:00:00Z", courses: [{course_code: "CS101", course_name: "Introduction to Computer Science"},
            {course_code: "CS102", course_name: "Data Structures and Algorithms"},
            {course_code: "CS103", course_name: "Database Management Systems"}]},
    {programme_code: "10BENG", NqfLevel: LEVEL_8, faculty: "Engineering", department_name:"Electrical Engineering", programme_title: "Bachelor of Engineering", registration_date: "2018-09-01T00:00:00Z", courses: [{course_code: "EE101", course_name: "Introduction to Electrical Engineering"},
            {course_code: "EE102", course_name: "Circuit Analysis"},
            {course_code: "EE103", course_name: "Digital Systems"}]}
];


public type ConflictingProgrammeCodeError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};
