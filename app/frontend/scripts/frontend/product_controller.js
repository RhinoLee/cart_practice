import Rails from "@rails/ujs";
document.addEventListener('turbolinks:load', function(){

  const productDataWrap = document.querySelector('#product-data') || ''

  if(productDataWrap) {
    
    const amountBtn = document.querySelectorAll('#product-data a.button.quantity')
    const submitBtn = document.querySelector('#product-data #add-to-cart')
    const quantityInput = document.querySelector('#product-data input[name=quantity]')
    const skuInput = document.querySelector('#product-data #product-item')
    
    amountBtn.forEach(btn => {
      btn.addEventListener('click', function(e){
        e.preventDefault()
        switch(true) {
  
          case btn.classList.contains('increase') : 
            quantityInput.value = quantityInput.value * 1 + 1
            break;
  
          case btn.classList.contains('decrease') : 
            quantityInput.value = quantityInput.value > 1 ? quantityInput.value - 1 : 1
            break;
  
        }
  
      })
    });

    submitBtn.addEventListener('click', function(e){
      e.preventDefault()
      let product_id = productDataWrap.dataset.product_id
      let quantity = quantityInput.value
      let sku = skuInput.value

      if(quantity > 0) {
        this.classList.add('is-loading')
        let data = new FormData();
        data.append("id", product_id)
        data.append("quantity", quantity)
        data.append("sku", sku)

        Rails.ajax({
          url: '/api/test',
          data,
          type: 'POST',
          dataType: 'json',
          success: res => {
            console.log(res);
          },
          error: err => {
            console.log(err);
          }
        })
      }


    })
    

  }

})