import Rails from "@rails/ujs";
document.addEventListener('turbolinks:load', function(){

  const submitButton = document.querySelector('#subscription-button')
  const emailInput = document.querySelector('#email_value')

  if(submitButton && emailInput){
    submitButton.addEventListener('click', function(e){
      e.preventDefault()


      let email = emailInput.value.trim()
      let data = new FormData();
      data.append("subscribe[email]", email);

      Rails.ajax({
        data,
        url: '/api/v1/subscribe',
        type: 'POST',
        dataType: 'json', 
        success: function(res){
          switch(res.status) {
            case 'ok': 
              alert('完成訂閱')
              emailInput.value = ''
              break;
            case 'duplicated' : 
              alert(`您的信箱：${res.email} 已經訂閱過囉！`)
              break;
          }
        },
        error: function(err){
          console.log(err);
        }
      })

    })
  }

})