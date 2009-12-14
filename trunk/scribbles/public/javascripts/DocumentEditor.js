// Global variables (referencing components)
var textarea_ph, textarea_ph_middle, textarea_ph_content;
var attachments_ph, attachments_ph_middle, attachments_ph_content;

var document_body;

var tab_files, tab_comments;
var document_lock, document_status, document_lock_message;
var files, comments;
var button_protect, button_share, button_print;
var button_comment, button_upload;
var popup_comment, popup_upload, popup_protect, popup_share;

var upload_file, upload_description, comment_name, comment_description;
var protect_password, protect_password_confirmation;
var share_recipient, share_name, share_message;

var curtain;

// General variables
var top = 55;
var isMozilla = false;
var ownLock = false;
var lockHolder;

// Animation variables
var faderButton, faderStatus, faderCurtain, faderLock;

var fadingButton;
var countdownStatus, countdownSave, countdownLock, countdownRefresh = 10;

function bodyLoad() {
	// Connect variables to components
	document_body = document.getElementById("document_body");
	
	textarea_ph = document.getElementById("div_textarea_ph");
	textarea_ph_middle = document.getElementById("div_textarea_ph_middle");
	textarea_ph_content = document.getElementById("div_textarea_content");
	
	attachments_ph = document.getElementById("div_attachments_ph");
	attachments_ph_middle = document.getElementById("div_attachments_ph_middle");
	attachments_ph_content = document.getElementById("div_attachments_ph_content");

	files = document.getElementById("div_files");
	comments = document.getElementById("div_comments");

	tab_files = document.getElementById("div_tab_files");
	tab_comments = document.getElementById("div_tab_comments");

	document_lock = document.getElementById("div_document_lock");
	document_lock_message = document.getElementById("document_lock_message");
	document_status = document.getElementById("div_document_status");

	button_protect = document.getElementById("div_button_protect");
	button_print = document.getElementById("div_button_print");
	button_share = document.getElementById("div_button_share");

	button_comment = document.getElementById("div_button_comment");
	button_upload = document.getElementById("div_button_upload");

	popup_comment = document.getElementById("div_popup_comment");
	popup_upload = document.getElementById("div_popup_upload");
	popup_protect = document.getElementById("div_popup_protect");
	popup_share = document.getElementById("div_popup_share");

	// Screen curtain
	curtain = document.getElementById("div_curtain");

	// Fields
	upload_file = document.getElementById("iframe_upload");
	upload_description = document.getElementById("upload_description");
	comment_name = document.getElementById("comment_name");
	comment_description = document.getElementById("comment_description");
	protect_password = document.getElementById("protect_password");
	protect_password_confirmation = document.getElementById("protect_password_confirmation");
	share_recipient = document.getElementById("share_recipient");
	share_name = document.getElementById("share_name");
	share_message = document.getElementById("share_message");

	// Locate non-moving parts
	button_protect.style.top = top + "px";
	button_protect.style.left = "10px";

	button_share.style.top = (90 + top) + "px";
	button_share.style.left = "10px";

	button_print.style.top = (180 + top) +"px";
	button_print.style.left = "10px";

	button_upload.style.left = "10px";
	button_comment.style.left = "10px";

	fadingButton = button_upload;

	// Detect browser
	if (window.innerHeight != undefined) {
		isMozilla = true;
	}

	// Locate all components
	locateComponents();

	// Fade out the loading image
	var loadingImage = document.getElementById("img_loading");
	loadingImage.style.visibility = "hidden";
	loadingImage.style.top = "0px";
	loadingImage.style.left = "0px";

	// Fade out the white curtain
	startFadeCurtain();

	// Start the counter
	window.setInterval("countdown();", 1000);
}

function locateLoadingImage() {
	// Get the dimensions
	var bodyWidth, bodyHeight;
	if (isMozilla) {
		bodyWidth = window.innerWidth;
		bodyHeight = window.innerHeight;
	}
	else {
		bodyWidth = document.documentElement.clientWidth;
		bodyHeight = document.documentElement.clientHeight;
	}

	var loadingImage = document.getElementById("img_loading");
	loadingImage.style.left = (bodyWidth / 2 - 16) + "px";
	loadingImage.style.top = (bodyHeight / 2 - 16) + "px";
}

function locateComponents(){
	// Get the dimensions
	var bodyWidth, bodyHeight;
	if (isMozilla) {
		bodyWidth = window.innerWidth;
		bodyHeight = window.innerHeight;
	}
	else {
		bodyWidth = document.documentElement.clientWidth;
		bodyHeight = document.documentElement.clientHeight;
	}

	// Enforce minimum size
	bodyWidth = Math.max(bodyWidth, 600);
	bodyHeight = Math.max(bodyHeight, 500);

	// Get text area coordinates
	var textareaTop = top;
	var textareaLeft = 108;
	var textareaWidth = bodyWidth - textareaLeft - 10;
	var textareaHeight = bodyHeight - textareaTop - 150;
	
	// Get attachments coordinates
	var attachmentsTop = textareaTop + textareaHeight + 5;
	var attachmentsHeight = bodyHeight - textareaHeight - textareaTop - 15;

	// Get popup coordinates
	var popup_top = (bodyHeight / 2 - 137);
	var popup_left = (bodyWidth / 2 - 225);

	// Locate the curtain
	curtain.style.width = bodyWidth + "px";
	curtain.style.height = bodyHeight + "px";

	// Locate the popups	
	popup_comment.style.top = popup_top + "px";
	popup_comment.style.left = popup_left + "px";

	popup_upload.style.top = popup_top + "px";
	popup_upload.style.left = popup_left + "px";

	popup_protect.style.top = popup_top + "px";
	popup_protect.style.left = popup_left + "px";

	popup_share.style.top = popup_top + "px";
	popup_share.style.left = popup_left + "px";

	// Locate the textarea
	textarea_ph.style.top = textareaTop + "px";
	textarea_ph.style.left = textareaLeft + "px";
	textarea_ph.style.width = textareaWidth + "px";
	textarea_ph.style.height = textareaHeight + "px";

	textarea_ph_middle.style.height = (textareaHeight - 30) + "px";
	textarea_ph_content.style.width = (textareaWidth - 30) + "px";
	
	// Locate the attachments
	attachments_ph.style.top = attachmentsTop + "px";
	attachments_ph.style.left = textareaLeft + "px";
	attachments_ph.style.width = textareaWidth + "px";
	attachments_ph.style.height = attachmentsHeight + "px";

	attachments_ph_middle.style.height = (attachmentsHeight - 30) + "px";
	attachments_ph_content.style.width = (textareaWidth - 30) + "px";

	files.style.width = (textareaWidth - 30) + "px";
	files.style.height = (attachmentsHeight - 40) + "px";

	comments.style.width = (textareaWidth - 30) + "px";
	comments.style.height = (attachmentsHeight - 40) + "px";

	// Locate the buttons
	button_comment.style.top = (attachmentsTop) + "px";
	button_upload.style.top = (attachmentsTop) + "px";

	// Locate the tabs
	tab_files.style.top = (attachmentsTop - 12) + "px";
	tab_comments.style.top = (attachmentsTop - 12) + "px";

	tab_files.style.left = (textareaLeft + 10) + "px";
	tab_comments.style.left = (textareaLeft + 95) + "px";

	// Locate the document lock
	document_lock.style.top = (textareaTop - 15) + "px";
	document_lock.style.left = (textareaLeft + textareaWidth - 218) + "px";

	// Locate the document status
	document_status.style.top = (textareaTop - 15) + "px";
	document_status.style.left = (textareaLeft + 13) + "px";
}

function activateTab(tabName) {
	if (tabName == 'files') {
		if (fadingButton == button_upload)
			return;

		tab_files.className = "tab tab_active";
		tab_comments.className = "tab tab_inactive";
		comments.style.visibility = "hidden";
		files.style.visibility = "visible";
		button_comment.style.visibility = "hidden";
		fadingButton = button_upload;
		
	}
	else {
		if (fadingButton == button_comment)
			return;
			
		tab_files.className = "tab tab_inactive";
		tab_comments.className = "tab tab_active";
		comments.style.visibility = "visible";
		files.style.visibility = "hidden";
		button_upload.style.visibility = "hidden";
		fadingButton = button_comment;
	}

	if (isMozilla)
		fadingButton.style.opacity = 0;
	else
		fadingButton.filters.alpha.opacity = 0;
		
	fadingButton.style.visibility = "visible";
	faderButton = window.setInterval("fadeButton();", 25);
}

function activateButton(button, state) {
	var className;
	if (state)
	{
		className = "button button_active";
	}
	else
	{
		className = "button button_inactive";
	}

	button.className = className;
}

function fadeButton() {
	// For mozilla
	if (isMozilla) {
		if (parseFloat(fadingButton.style.opacity) == 1)
		{
			window.clearInterval(faderButton);
			return;
		}

		fadingButton.style.opacity = parseFloat(fadingButton.style.opacity) + 0.1;
	}
	else {
		if (parseInt(fadingButton.filters.alpha.opacity) == 100) {
			window.clearInterval(faderButton);
			return;
		}

		fadingButton.filters.alpha.opacity = parseInt(fadingButton.filters.alpha.opacity) + 10;	
	}
}

function fadeLock() {
	// For mozilla
	if (isMozilla) {
		if (parseFloat(document_lock.style.opacity) == 0) {
			window.clearInterval(faderLock);
			document_lock.style.visibility = "hidden";
			return;
		}

		document_lock.style.opacity = parseFloat(document_lock.style.opacity) - 0.1;
	}
	else {
		if (parseInt(document_lock.filters.alpha.opacity) == 0) {
			window.clearInterval(faderLock);
			document_lock.style.visibility = "hidden";
			return;
		}

		document_lock.filters.alpha.opacity = parseInt(document_lock.filters.alpha.opacity) - 10;
	}
}

function fadeStatus() {
	// For mozilla
	if (isMozilla) {
		if (parseFloat(document_status.style.opacity) == 0) {
			window.clearInterval(faderStatus);
			document_status.style.visibility = "hidden";
			return;
		}

		document_status.style.opacity = parseFloat(document_status.style.opacity) - 0.1;
	}
	else {
		if (parseInt(document_status.filters.alpha.opacity) == 0) {
			window.clearInterval(faderStatus);
			document_status.style.visibility = "hidden";
			return;
		}

		document_status.filters.alpha.opacity = parseInt(document_status.filters.alpha.opacity) - 10;
	}
}

function startFadeLock() {
	faderLock = window.setInterval("fadeLock();", 10);
}

function startFadeCurtain() {
	faderCurtain = window.setInterval("fadeCurtain();", 10);
}

function startFadeStatus() {
	faderStatus = window.setInterval("fadeStatus();", 10);
}

function showCurtain(color) {
	if (color != null) {
		curtain.style.backgroundColor = color;
	} 
	else {
		curtain.style.backgroundColor = "#AAAAAA";
	}

	curtain.style.visibility = "visible";
	if (isMozilla) {
		curtain.style.opacity = 0.5;
	}
	else {
		curtain.filters.alpha.opacity = 50;
	}
}

function fadeCurtain() {
	// For mozilla
	if (isMozilla) {
		if (parseFloat(curtain.style.opacity) == 0) {
			window.clearInterval(faderCurtain);
			curtain.style.visibility = "hidden";
			return;
		}
		curtain.style.opacity = parseFloat(curtain.style.opacity) - 0.1;
	}
	else {
		if (parseInt(curtain.filters.alpha.opacity) == 0) {
			window.clearInterval(faderCurtain);
			curtain.style.visibility = "hidden";
			return;
		}
		curtain.filters.alpha.opacity = parseInt(curtain.filters.alpha.opacity) - 25;
	}
}

function showPopup(popup) {
	var popupDiv, focusObject;
	// Hide all popups
	hidePopups();

	if (popup == "upload") {
		popupDiv = popup_upload;
		upload_file.src = "documents/Upload/" + documentId;
	}
	else if (popup == "comment") {
		popupDiv = popup_comment;
		focusObject = comment_name;
	}
	else if (popup == "share") {
		popupDiv = popup_share;
		focusObject = share_name;
	}
	else if (popup == "protect") {
		popupDiv = popup_protect;
		focusObject = protect_password;
	}

	showCurtain();
	popupDiv.style.visibility = "visible";
	
	if (focusObject != null)
		focusObject.focus();
}

function hidePopups(hideCurtain) {
	// Hide stuff!
	popup_comment.style.visibility = "hidden";
	popup_upload.style.visibility = "hidden";
	popup_protect.style.visibility = "hidden";
	popup_share.style.visibility = "hidden";

	document.getElementById("comment_error").style.visibility = "hidden";
	document.getElementById("comment_progress").style.visibility = "hidden";
	document.getElementById("share_error").style.visibility = "hidden";
	document.getElementById("share_progress").style.visibility = "hidden";
	document.getElementById("upload_error").style.visibility = "hidden";
	document.getElementById("upload_progress").style.visibility = "hidden";
	document.getElementById("protect_error").style.visibility = "hidden";
	document.getElementById("protect_progress").style.visibility = "hidden";

	// Remove curtain
	if (hideCurtain) {
		startFadeCurtain();
	}
	
	// Reset fields
	upload_file.src="about:blank";
	upload_description.value = "";
	comment_name.value = loggedInUser;
	comment_description.value = "";
	protect_password.value = "";
	protect_password_confirmation.value = "";
	share_recipient.value = "";
	share_name.value = loggedInUser;
	share_message.value = "Check out this document ;)";
}

function uploadFile() {
	if (!upload_file.contentWindow.beginUpload(documentId, upload_description.value)) {
		showError("upload", "Choose a file");
		return;
	}

	showProgress("upload");
}

function addComment() {
	if (comment_name.value == "") {
		showError("comment", "Enter your name");
		comment_name.focus();
		return;
	}

	if (comment_description.value == "") {
		showError("comment", "Enter your comment");
		comment_description.focus();
		return;
	}

	showProgress("comment");
	document.getElementById("iframe_comment").contentWindow.insertValues(documentId, comment_name.value, comment_description.value);
	
}

function setPassword() {
	if (protect_password.value == "") {
		showError("protect", "Enter a password");
		protect_password.focus();
		return;
	}

	if (protect_password.value != protect_password_confirmation.value) {
		showError("protect", "Passwords do not match");
		protect_password.focus();
		return;
	}

	showProgress("protect");
}

function emailLink() {
	if (share_name.value == "") {
		showError("share", "Enter your name");
		share_name.focus();
		return;
	}

	if (share_recipient.value == "") {
		showError("share", "Enter recipient's email");
		share_recipient.focus();
		return;
	}

	if (!validEmail(share_recipient.value)) {
		showError("share", "Invalid recipient email");
		share_recipient.focus();
		return;
	}

	showProgress("share");
}

function showError(popup, message) {
	document.getElementById(popup + "_progress").style.visibility = "hidden";
	document.getElementById(popup + "_error_message").innerHTML = message;
	document.getElementById(popup + "_error").style.visibility = "visible";
}

function showProgress(popup) {
	document.getElementById(popup + "_error").style.visibility = "hidden";
	document.getElementById(popup + "_progress").style.visibility = "visible";
}

function validEmail(email) {
	var filter = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;
	return filter.test(email);
}

function printDocument() {
	var t = "TODO";
	var b = document_body.value;

	b = b.replace("<", "&lt;");
	b = b.replace("\r", "");
	b = b.replace("\n", "</p><p>");
	b = "<p>" + b + "</p>";

	document.getElementById("iframe_print").contentWindow.printDocument(t, b);
}

function countdown() {
	// Count down!
	if (countdownSave >= 0)
		countdownSave -= 1;
	
	if (countdownStatus >= 0)
		countdownStatus -= 1;

	if (countdownLock >= 0)
		countdownLock -= 1;

	if (countdownRefresh >= 0)
		countdownRefresh -= 1;

	if (countdownRefresh == 0) {
		refreshComments();
		refreshFiles();
		if (!ownLock) {
			refreshDocument();
		}
		countdownRefresh = 10;
	}

	if (countdownSave == 0) {
		// Save!
		saveDocument();
	}

	if (countdownStatus == 0) {
		// Fade out status
		startFadeStatus();
	}

	if (countdownLock == 0) {
		// Release the lock
		releaseLock();
	}
}

function setStatus(message)
{
	if (document_status == null)
		document_status = document.getElementById("div_document_status");
		
	document_status.innerHTML = message;
	if (isMozilla) {
		document_status.style.opacity = 1;
	}
	else {
		document_status.filters.alpha.opacity = 100;
	}

	document_status.style.visibility = "visible";
	countdownStatus = 5;	
}

function saveDocument() {
	setStatus("Saving the document...");
	document.getElementById("iframe_document").contentWindow.insertValues(documentId, document_body.value);	
}

function releaseLock() {
	ownLock = false;
	startFadeLock();
}

function bodyChanged() {
	acquireLock();
	countdownSave = 2;
	countdownLock = 10;
}

function acquireLock() {
	ownLock = true;
	setLockMessage("You've got the lock");
}

function setLockMessage(message) {
	document_lock_message.innerHTML = message;
	if (isMozilla) {
		document_lock.style.opacity = 1;
	}
	else {
		document_lock.filters.alpha.opacity = 100;
	}

	document_lock.style.visibility = "visible";
}

function succeed(activity) {
	hidePopups(true);
	if (activity == "comment") {
		setStatus("Comment added");
		countdownRefresh = 1;
	}
	else if (activity == "upload") {
		setStatus("File uploaded");
		countdownRefresh = 1;
	}
	else if (activity == "document") {
		setStatus("Document saved");
		countdownRefresh = 1;
	}
}

function refreshComments() {
	document.getElementById("iframe_comment_update").contentWindow.location.reload();
}

function updateComments() {
	var comment = document.getElementById("iframe_comment_update").contentWindow.document.body.innerHTML;
	if (comments == null)
		comments = document.getElementById("div_comments");

	comments.innerHTML = comment;
}

function refreshFiles() {
	document.getElementById("iframe_files_update").contentWindow.location.reload();
}

function updateFiles() {
	var file = document.getElementById("iframe_files_update").contentWindow.document.body.innerHTML;
	if (files == null)
		files = document.getElementById("div_files");

	files.innerHTML = file;
}

function refreshDocument() {
	document.getElementById("iframe_document_update").contentWindow.location.reload();
}

function updateDocument() {
	var body = document.getElementById("iframe_document_update").contentWindow.document.getElementById("documentBody").value;
	if (document_body == null)
		document_body = document.getElementById("document_body");

	// Any changes?
	if (document_body.value != body) {
		document_body.value = body;
		setStatus("Document refreshed");
	}
}

function checkUploadStatus() {
	var source = document.getElementById("iframe_upload").src;
	var content = document.getElementById("iframe_upload").contentWindow.document.body.innerHTML;
	
	if (source != "about:blank" && content == "")
	{
		succeed("upload");
	}
}
var commented = false;
function checkCommentStatus() {
	if (commented)
		succeed("comment");
		
	commented = true;
}

var bodySaved = false;
function checkDocumentStatus() {
	if (bodySaved)
		succeed("document");
		
	bodySaved = true;
}

function checkLockStatus() {
	
}