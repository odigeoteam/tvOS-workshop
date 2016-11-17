/*
Copyright (C) 2016 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
This class handles fetching and presenting simple templates.
*/

// Registry of attribute name used to define the URL to template (e.g. documentURL or menuBarDocumentURL)
// to controller type (e.g. DocumentController or MenuBarController)
const attributeToController = {};
const attributeKeys = [];

function registerAttributeName(type, func) {
    attributeToController[type] = func;
    attributeKeys.push(type);
}

function resolveControllerFromElement(elem) {
    for (let key of attributeKeys) {
        if (elem.hasAttribute(key)) {
            return {
                type: attributeToController[key],
                url: elem.getAttribute(key)
            };
        }
    }
}

class DocumentController {

    constructor(documentLoader, documentURL, loadingDocument) {
        this.handleEvent = this.handleEvent.bind(this);
        this._documentLoader = documentLoader;
        this.fetchDocument(documentURL, loadingDocument);
    }

    fetchDocument(documentURL, loadingDocument) {
        this._documentLoader.fetch({
            url: documentURL,
            success: (document) => {
                // Add the event listener for document
                this.setupDocument(document);
                // Allow subclass to do custom handling for this document
                this.handleDocument(document, loadingDocument);
            },
            error: (xhr) => {
                const alertDocument = createLoadErrorAlertDocument(documentURL, xhr, false);
                this.handleDocument(alertDocument, loadingDocument);
            }
        });
    }

    setupDocument(document) {
        document.addEventListener("select", this.handleEvent);
    }

    handleDocument(document, loadingDocument) {
        if (loadingDocument) {
            navigationDocument.replaceDocument(document, loadingDocument);
        } else {
            navigationDocument.pushDocument(document);
        }
    }

    handleEvent(event) {
        let target = event.target;
        
        const controllerOptions = event.type === 'play' ? { type: attributeToController["searchDocumentURL"], url: "/templates/Search.xml"} : resolveControllerFromElement(target);
        if (controllerOptions) {
            const controllerClass = controllerOptions.type;
            const documentURL = controllerOptions.url;
            var loadingDocument;
            if (!controllerClass.preventLoadingDocument) {
                loadingDocument = createLoadingDocument();
                navigationDocument.pushDocument(loadingDocument);
            }
            // Create the subsequent controller based on the atribute and its value. Controller would handle its presentation.
            new controllerClass(this._documentLoader, documentURL, loadingDocument);
        } else if (target.tagName === 'description') {
            // Handle description tag, if no URL was specified
            const body = target.textContent;
            const alertDocument = createDescriptiveAlertDocument('', body);
            navigationDocument.presentModal(alertDocument);
        }
    }
}

registerAttributeName('documentURL', DocumentController);
