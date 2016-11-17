/**
 * @description The onLaunch callback is invoked after the application JavaScript
 * has been parsed into a JavaScript context. The handler is passed an object
 * that contains options. These options are defined in the Swift or objective-c client code.
 * Options can be used to communicate data and state information to your JavaScript code.
 *
 * The location attribute is automatically added to the options object and represents
 * the URL that was used to retrieve the application JavaScript.
 */
App.onLaunch = function(options) {
    // Determine the base URL for remote server fetches from launch options, which will be used to resolve the URLs
    // in XML files for this app.
    const baseURL = options.baseURL;

    // Specify all the URLs for helper JavaScript files
    const helperScriptURLs = [
        "DocumentLoader",
        "DocumentController",
        "ListController"
    ].map(
        moduleName => `${baseURL}js/${moduleName}.js`
    );

    // Show a loading spinner while additional JavaScript files are being evaluated
    const loadingDocument = createLoadingDocument();
    navigationDocument.pushDocument(loadingDocument);

    // evaluateScripts is responsible for loading the JavaScript files neccessary
    // for this app to run. It can be used at any time in your apps lifecycle.
    evaluateScripts(helperScriptURLs, function(scriptsAreLoaded) {
        if (scriptsAreLoaded) {
            // Instantiate the DocumentLoader, which will be used to fetch and resolve URLs from the fecthed XML documents.
            // This instance is passed along to subsequent DocumentController objects.
            const documentLoader = new DocumentLoader(baseURL);
            const startDocURL = documentLoader.prepareURL("/templates/List.xml");
            // Instantiate the controller with root template. The controller is passed in the loading document which
            // was pushed while scripts were being evaluated, and controller will replace it with root template once
            // fetched from the server.
            new ListController(documentLoader, startDocURL, loadingDocument);
        } else {
            // Handle error cases in your code. You should present a readable and user friendly
            // error message to the user in an alert dialog.
            const alertDocument = createEvalErrorAlertDocument();
            navigationDocument.replaceDocument(alertDocument, loadingDocument);
            throw new EvalError("TVMLCatalog application.js: unable to evaluate scripts.");
        }
    });
};

/**
 * Convenience function to create a TVML loading document with a specified title.
 */
function createLoadingDocument(title) {
    // If no title has been specified, fall back to "Loading...".
    title = title || "Loading...";

    const template = `<?xml version="1.0" encoding="UTF-8" ?>
        <document>
            <loadingTemplate>
                <activityIndicator>
                    <title>${title}</title>
                </activityIndicator>
            </loadingTemplate>
        </document>
    `;
    return new DOMParser().parseFromString(template, "application/xml");
}

/**
 * Convenience function to create a TVML alert document with a title and description.
 */
function createAlertDocument(title, description) {
    const template = `<?xml version="1.0" encoding="UTF-8" ?>
        <document>
            <alertTemplate>
                <title>${title}</title>
                <description>${description}</description>
            </alertTemplate>
        </document>
    `;
    return new DOMParser().parseFromString(template, "application/xml");
}

/**
 * Convenience function to create a TVML alert document with a title and description.
 */
function createDescriptiveAlertDocument(title, description) {
    const template = `<?xml version="1.0" encoding="UTF-8" ?>
        <document>
            <descriptiveAlertTemplate>
                <title>${title}</title>
                <description>${description}</description>
            </descriptiveAlertTemplate>
        </document>
    `;
    return new DOMParser().parseFromString(template, "application/xml");
}

/**
 * Convenience function to create a TVML alert for failed evaluateScripts.
 */
function createEvalErrorAlertDocument() {
    const title = "Evaluate Scripts Error";
    const description = [
        "There was an error attempting to evaluate the external JavaScript files.",
        "Please check your network connection and try again later."
    ].join("\n\n");
    return createAlertDocument(title, description);
}


/**
 * Convenience function to create a TVML alert for a failed XMLHttpRequest.
 */
function createLoadErrorAlertDocument(url, xhr) {
    const title = (xhr.status) ? `Fetch Error ${xhr.status}` : "Fetch Error";
    const description = `Could not load document:\n${url}\n(${xhr.statusText})`;
    return createAlertDocument(title, description);
}
