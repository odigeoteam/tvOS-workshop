/*
 Copyright (C) 2016 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 This class handles presenting the List template example.
 */

 class ListController extends DocumentController {
    
    setupDocument(document) {
        super.setupDocument(document);
        
        const documentLoader = this._documentLoader
        document.addEventListener("play", openSearch);
        
        const collectionList = document.getElementById("collectionList");
        document.addEventListener("highlight", changeTitle)
        
        function openSearch(event) {
            let target = event.target;
            
            const controllerOptions = { type: attributeToController["searchDocumentURL"], url: "/templates/Search.xml"};
            const controllerClass = controllerOptions.type;
            const documentURL = controllerOptions.url;
            var loadingDocument;
            if (!controllerClass.preventLoadingDocument) {
                loadingDocument = createLoadingDocument();
                navigationDocument.pushDocument(loadingDocument);
            }
            
            new controllerClass(documentLoader, documentURL, loadingDocument);
        }

        function changeTitle(event) {
            
            const stackTemplateElement = event.currentTarget;
            const triggerElement = event.target;

            const titleTriggerElementArray = triggerElement.getElementsByTagName('title');

            if (titleTriggerElementArray.length > 0) {
                const titleTriggerElement = titleTriggerElementArray.item(0);
                const headerTitle = stackTemplateElement.getElementById("headerTitle");
                headerTitle.textContent = titleTriggerElement.textContent;                
            }
        }        
    }
}
