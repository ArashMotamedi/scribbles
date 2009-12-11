function beginUpload(docId, description) {
	// Write file name in the progress
	var fileName = document.getElementById("file").value;
	if (fileName == null || fileName == "") {
		return false;
	}
	fileName = fileName.substring(fileName.lastIndexOf("\\"));

	// Add Description
	document.getElementById("description").value = description;

	document.getElementById("div_progress").innerHTML = fileName;
	
	document.getElementById("div_form").style.visibility = "hidden";
	document.getElementById("div_progress").style.visibility = "visible";
	
	// Submit the form
	document.forms[0].action = "documents/UploadFile/" + docId;
	document.forms[0].submit();
	
	return true;
}