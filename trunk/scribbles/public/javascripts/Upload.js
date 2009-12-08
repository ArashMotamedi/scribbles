function beginUpload() {
	// Write file name in the progress
	var fileName = document.getElementById("file").value;
	if (fileName == null || fileName == "") {
		return false;
	}
	fileName = fileName.substring(fileName.lastIndexOf("\\"));

	document.getElementById("div_progress").innerHTML = fileName;
	
	document.getElementById("div_form").style.visibility = "hidden";
	document.getElementById("div_progress").style.visibility = "visible";

	return true;
}