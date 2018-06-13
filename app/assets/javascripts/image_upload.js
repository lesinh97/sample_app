$('#micropost_picture').bind('change', function() {
  var size_in_megabytes = this.files[0].size/1024/1024;
  if (size_in_megabytes > <%= Settings.max_picture_size %>) {
    alert('<%= I18n.t('static_pages.home.pic_out_size_alert') %>');
  }
});
