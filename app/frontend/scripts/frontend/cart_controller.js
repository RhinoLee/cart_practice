document.addEventListener('turbolinks:load', function(){

  const showCartItemsCount = document.querySelector('span#cart-item-count') || ''
  if(showCartItemsCount) {
    
    document.addEventListener('addToCart', function(obj){

      let data = obj.detail
      showCartItemsCount.innerText = `(${data.item_count})`

    })
  }

})