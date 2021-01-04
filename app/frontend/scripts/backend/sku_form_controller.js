document.addEventListener('turbolinks:load', function(){

  const addItemButton = document.querySelector('.add-item-button') || ''
  const skuChildForm = document.querySelector('.sku_child')
  const content = skuChildForm ? skuChildForm.innerHTML.replace(/NEW_RECORD/g, new Date().getTime()) : ''


  if(addItemButton) {
    addItemButton.addEventListener('click', function(e){
      e.preventDefault()
      this.insertAdjacentHTML('beforebegin', content)
  
      const deleteButton = document.querySelectorAll('.button.is-danger')
      deleteButton.forEach(btn => {
        btn.addEventListener('click', function(e){
          e.preventDefault()
          let wrapper = this.closest('.nested-fields')
          if(wrapper.dataset.newRecord == 'true') {
            wrapper.remove()
          }else {
            wrapper.querySelector("input[name*='_destroy]").value = 1 
            wrapper.style.display = 'none'
          }
        })
      })
  
    })
  }
  

})