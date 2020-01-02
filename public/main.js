contentArea = document.getElementById('contentArea')
contentArea.onkeyup = function () {
  count = document.getElementById('count')
  count.innerHTML = "Characters left: " + (500 - this.value.length);
};
