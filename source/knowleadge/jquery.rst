Learn some jquery
=======================

.. code:: javascript

  $('li')
  $('li').first()
  $('li').first().show()
  $('ul':first).children()
  $('li:first').siblings()
  $('li:first').parent()
  $(this).siblings().remove()
  $(this).siblings().addClass('special')
  $('li').closest('.list').addClass('special')
  $('.list').find('li').filter('.special').remove()
  $('.list').find('.special').remove()

  if( $(this).is('.special') ) {

  }
  if( $(this).not('.special')){

  }

  $('.sublist li').on('click', function(){
    $(this).hide();
  });
