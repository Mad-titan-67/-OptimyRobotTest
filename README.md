# Robot Framework Test - Application Submission

## Overview
This Robot Framework script automates the submission of a new application on a web page. The test includes login, form submission, validation, and verification steps.

## Prerequisites
1. [Python](https://www.python.org/downloads/) installed.
2. [Robot Framework](https://robotframework.org/) installed. You can install it using pip:

    ```bash
    pip install robotframework
    ```

3. [SeleniumLibrary](https://github.com/robotframework/SeleniumLibrary) installed. Install it using:

    ```bash
    pip install robotframework-seleniumlibrary
    ```

4. [ChromeDriver](https://sites.google.com/chromium.org/driver/) installed and added to your system's PATH.

## Usage
1. Clone this repository:

    ```bash
    git clone https://github.com/yourusername/-OptimyRobotTest.git
    ```

2. Navigate to the project directory:

    ```bash
    cd -OptimyRobotTest
    ```

3. Execute the Robot Framework script:

    ```bash
    robot -d results tests/SubmitApplicationTest.robot
    ```

    This will run the test and generate a report in the `results` directory.

## Test Configurations
1. **Credentials**: Update the `${USERNAME}` and `${PASSWORD}` variables in the `SubmitApplicationTest.robot` file with valid credentials.

2. **Web Browser**: The script is configured to run on Chrome by default. You can change the browser by modifying the `Open Browser` keyword in the test.

## Author
Punith T
