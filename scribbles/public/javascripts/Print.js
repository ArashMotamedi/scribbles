function printDocument(title, body) {
	document.title = title;

	document.getElementById("title").innerHTML = title;
	document.getElementById("body").innerHTML = body;

	window.print();
}