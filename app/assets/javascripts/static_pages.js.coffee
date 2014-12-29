# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('table.datatable').dataTable
	  processing: true
	  serverSide: true
	  ajax: $('table.datatable').data('source')
	  pagingType: 'full_numbers'