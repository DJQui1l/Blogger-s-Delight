contentArea = document.getElementById('contentArea')
contentArea.onkeyup = function () {
  count = document.getElementById('count')
  count.innerHTML = "Characters left: " + (500 - this.value.length);
};

// -------------- DELETE BOX in profile.erb ------------------
// deleteBtn = getElementById('deleteBtn');
editBtn = document.getElementById('editPosts');

postContent = document.getElementById('post-content-57')

postsdisabled = true
  editBtn.addEventListener('click', function(){
  // console.log("made true");
  switch (postsdisabled){
    case true:
    console.log("is editable");
      postContent.disabled = false;
        postsdisabled = false;
        editForm = document.getElementById('editForm')
        submitInput = document.createElement('input')
          submitInput.setAttribute('type','submit')
        cancelInput = document.createElement('button')
          cancelInput.setAttribute('type','button')
          cancelInput.innerText ="Cancel"

        editForm.appendChild(submitInput)
        editForm.appendChild(cancelInput)

        editBtn.style.visibility = 'hidden'

        cancelInput.addEventListener('click', function(){
          console.log('is not editable');
          editBtn.style.visibility = 'visible'
          postContent.disabled = true;
          postsdisabled = true;

          submitInput.remove()
          cancelInput.remove()
            })



        break
      case false:
      postContent.disabled = true;
      postsdisabled = true;
      console.log("is not editable");

      submitInput.remove()
      cancelInput.remove()

      break



  // editForm = document.createElement('form')
    // editInput = document.createElement('input')
      // editInput.setAttribute('id','editValue')
    // submitInput = document.createElement('input')
      // submitInput.setAttribute('type','submit')
    // editInput.value = postContent.value
  }


  })
