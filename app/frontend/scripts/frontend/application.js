import Swiper, { Navigation, Pagination } from 'swiper';
Swiper.use([Navigation, Pagination]);

document.addEventListener('turbolinks:load', function(){
  var mySwiper = new Swiper('.swiper-container', {
    slidesPerView: 3,
    loop: true,
    pagination: {
      el: '.swiper-pagination.index',
      clickable: true
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
  })


})