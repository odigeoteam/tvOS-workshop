

App.onLaunch = function(options) {
    var template = `
        <document>
            <loadingTemplate>
                <activityIndicator>
                    <text>Hello World!</text>
                </activityIndicator>
            </loadingTemplate>
        </document>`;
    var templateParser = new DOMParser();
    var parsedTemplate = templateParser.parseFromString(template, "application/xml");
    navigationDocument.pushDocument(parsedTemplate);
}
