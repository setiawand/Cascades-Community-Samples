/* Copyright (c) 2012 Research In Motion Limited.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
import bb.cascades 1.0
import "common"

Page {
    content: MenuContainer {

	    id: writeUri
	    objectName: "writeUri"

// ======== Properties =============

	    property alias ndefUri: txf_uri.text

// ======== SIGNAL()s ==============
// ======== SLOT()s ================
// ======== Local functions ========

        Container {
            layout: StackLayout {
            }

            topPadding: 5
            leftPadding: 30
            rightPadding: 30

            Label {
                text: "Write a URI Tag"
                textStyle {
                    base: SystemDefaults.TextStyles.TitleText
                    color: Color.LightGray
                    fontWeight: FontWeight.Bold
                }
            }

		    TextArea {
		        editable: false
		        text: "Enter the URI you wish to write to the tag"
		        textStyle {
		            base: SystemDefaults.TextStyles.BodyText
		            color: Color.LightGray
		            lineHeight: 1.1
		        }
		    }
		
		    TextArea {
		        id: txf_uri
		        objectName: "txf_uri"
		        hintText: "Enter the uri you wish to write to the tag"
		        text: "http://www.bbc.co.uk"
		        textStyle {
                    base: SystemDefaults.TextStyles.BodyText
		        }
                horizontalAlignment: HorizontalAlignment.Right
                maxWidth: 685
		    }

            TextArea {
                editable: false
                text: "Now click the Share icon in the Action Bar to write the data to a tag."
                textStyle {
		            base: SystemDefaults.TextStyles.BodyText
                    color: Color.LightGray
                    lineHeight: 1.1
                }
            }
        }
	}

	actions: [
        InvokeActionItem {
            id: sharedNdefData
	        ActionBar.placement: ActionBarPlacement.OnBar
            query {
                mimeType: "application/vnd.rim.nfc.ndef"
                invokeActionId: "bb.action.SHARE"
            }
            handler: InvokeHandler {
                id: shareHandler
                onInvoking: {
                    sharedNdefData.data = _ndefFactory.getNdefUriMessage(writeUri.ndefUri);
                    shareHandler.confirm();
                }
            }
        }
	]
}
