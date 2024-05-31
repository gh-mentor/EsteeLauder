/*
This app demonstrates creating a class using copilot with TypeScript.
To use this app, run the following command:
tsc UserProfile.ts
node UserProfile.js
*/

interface IUserProfile {
    printProfile(): void;
    updateEmail(email: string): void;
    updatePhoneNumber(phoneNumber: string): void;
}

/*
Create a class called 'UserProfile' with the following private properties:
- username: string
- email: string
- age: number
- phoneNumber: string

Define the following public methods:
- A constructor that initializes the properties of the class
- A method called printProfile that prints the user's profile information
- A method that updates the user email
- A method that updates the user phone number
*/

class UserProfile implements IUserProfile {
    private username: string;
    private email: string;
    private age: number;
    private phoneNumber: string;

    constructor(username: string, email: string, age: number, phoneNumber: string) {
        this.username = username;
        this.email = email;
        this.age = age;
        this.phoneNumber = phoneNumber;
    }

    /**
     * Prints the user profile information.
     */
    printProfile(): void {
        console.log(`Username: ${this.username}`);
        console.log(`Email: ${this.email}`);
        console.log(`Age: ${this.age}`);
        console.log(`Phone Number: ${this.phoneNumber}`);
    }

    /**
     * Updates the email address of the user.
     * @example updateEmail("a@borrows.com")
     * @param email - The new email address.
     * @returns void
     */
    updateEmail(email: string): void {
        this.email = email;
    }

    updatePhoneNumber(phoneNumber: string): void {
        // Validate phone number using a regular expression then update if valid
        // If not valid, throw an error message
        let phonePattern = /^\d{10}$/;
        if (phonePattern.test(phoneNumber)) {
            this.phoneNumber = phoneNumber;
        } else {
            // Throw an error message
            throw new Error("Invalid phone number");
        }
    }
}

// export default UserProfile;

