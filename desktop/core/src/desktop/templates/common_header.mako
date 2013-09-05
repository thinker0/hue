## Licensed to Cloudera, Inc. under one
## or more contributor license agreements.  See the NOTICE file
## distributed with this work for additional information
## regarding copyright ownership.  Cloudera, Inc. licenses this file
## to you under the Apache License, Version 2.0 (the
## "License"); you may not use this file except in compliance
## with the License.  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
<%!
from desktop import conf
import urllib
from desktop.lib.i18n import smart_unicode
from django.utils.translation import ugettext as _
%>

<%def name="is_selected(selected)">
  %if selected:
    class="active"
  %endif
</%def>

<%def name="get_title(title)">
  % if title:
    - ${smart_unicode(title)}
  % endif
</%def>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Hue - ${current_app.nice_name} ${get_title(title)}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

  <link href="/static/ext/css/bootplus.css" rel="stylesheet">
  <link href="/static/ext/css/font-awesome.min.css" rel="stylesheet">
  <link href="/static/css/hue3.css" rel="stylesheet">
  <link href="/static/ext/css/fileuploader.css" rel="stylesheet">

  <style type="text/css">
    % if conf.CUSTOM.BANNER_TOP_HTML.get():
      body {
        padding-top: ${str(int(padding[:-2]) + 40) + 'px'};
      }
      .banner {
        height: 40px;
        padding: 0px;
      }
      .subnav-fixed {
        top: 80px;
      }
    % else:
      body {
        padding-top: ${padding};
      }
    % endif
  </style>

  <script type="text/javascript" charset="utf-8">

    // jHue plugins global configuration
    jHueFileChooserGlobals = {
      labels: {
        BACK: "${_('Back')}",
        SELECT_FOLDER: "${_('Select this folder')}",
        CREATE_FOLDER: "${_('Create folder')}",
        FOLDER_NAME: "${_('Folder name')}",
        CANCEL: "${_('Cancel')}",
        FILE_NOT_FOUND: "${_('The file has not been found')}",
        UPLOAD_FILE: "${_('Upload a file')}",
        FAILED: "${_('Failed')}"
      },
      user: "${ user.username }"
    };

    jHueTableExtenderGlobals = {
      labels: {
        GO_TO_COLUMN: "${_('Go to column:')}",
        PLACEHOLDER: "${_('column name...')}"
      }
    };

    jHueTourGlobals = {
      labels: {
        AVAILABLE_TOURS: "${_('Available tours')}",
        NO_AVAILABLE_TOURS: "${_('None for this page.')}"
      }
    };

  </script>

  <script src="/static/ext/js/jquery/jquery-2.0.2.min.js"></script>
  <script src="/static/js/jquery.migration.js"></script>
  <script src="/static/js/jquery.filechooser.js"></script>
  <script src="/static/js/jquery.selector.js"></script>
  <script src="/static/js/jquery.alert.js"></script>
  <script src="/static/js/jquery.rowselector.js"></script>
  <script src="/static/js/jquery.notify.js"></script>
  <script src="/static/js/jquery.tablescroller.js"></script>
  <script src="/static/js/jquery.tableextender.js"></script>
  <script src="/static/js/jquery.scrollup.js"></script>
  <script src="/static/js/jquery.tour.js"></script>
  <script src="/static/ext/js/jquery/plugins/jquery.cookie.js"></script>
  <script src="/static/ext/js/jquery/plugins/jquery.total-storage.min.js"></script>
  <script src="/static/ext/js/jquery/plugins/jquery.placeholder.min.js"></script>
  <script src="/static/ext/js/jquery/plugins/jquery.dataTables.1.8.2.min.js"></script>
  <script src="/static/js/jquery.datatables.sorting.js"></script>
  <script src="/static/ext/js/bootstrap.min.js"></script>
  <script src="/static/ext/js/fileuploader.js"></script>

  <script type="text/javascript" charset="utf-8">
    $(document).ready(function(){
      $("input, textarea").placeholder();
      $(".submitter").keydown(function(e){
        if (e.keyCode==13){
          $(this).closest("form").submit();
        }
      }).change(function(){
        $(this).closest("form").submit();
      });

      $(".navbar .nav-tooltip").tooltip({
        delay:0,
        placement:'bottom'});

      $("[rel='tooltip']").tooltip({
        delay:0,
        placement:'right'});
    });
  </script>
</head>
<body>
<div class="navbar navbar-inverse navbar-fixed-top">
    % if conf.CUSTOM.BANNER_TOP_HTML.get():
    <div id="banner-top" class="banner">
        ${conf.CUSTOM.BANNER_TOP_HTML.get()}
    </div>
    % endif
    <div class="navbar-inner">
      <div class="container-fluid">
        <a class="brand nav-tooltip" title="${_('About Hue')}" href="/about"><img src="/static/art/hue-logo-mini.png" /></a>

        % if user.is_authenticated():
          <ul class="nav pull-right">
          <li class="divider-vertical"></li>
          <li><a href="login.html"><i class="icon-file"></i>&nbsp;FB &nbsp;</a></li>
          <li><a href="login.html"><i class="icon-list-alt"></i>&nbsp;JB &nbsp;<span class="label label-warning">6</span></a></li>
          <li class="dropdown">
            <a href="index.html#" data-toggle="dropdown" class="dropdown-toggle"><i class="icon-cogs"></i>&nbsp;&nbsp;<b class="caret"></b></a>
            <ul class="dropdown-menu">
              <li><a href="user-account.html"><i class="icon-file"></i>&nbsp;&nbsp;User information</a></li>
              <li><a href="password.html"><i class="icon-key"></i>&nbsp;&nbsp;Change Password</a></li>
            </ul>
          </li>
          <li><a href="login.html"><i class="icon-lock"></i>&nbsp;&nbsp;Logout</a></li>
          <li><a href="login.html"><i class="icon-question-sign"></i></a></li>
        </ul>
        % endif

        <div class="nav-collapse">
          <ul class="nav">
            <li>
              <a class="nav-tooltip" title="${current_app.nice_name} Home" href="/${current_app.display_name}"><img src="${current_app.icon_path}" /></a>
            </li>
            <li class="currentApp">
              ${current_app.nice_name}
            </li>
            <li class="divider-vertical"></li>
            %for item in menubar:
              <li ${is_selected(item['selected'])}><a href="${item['url']}" style="margin-top: 4px">${item['name']}</a></li>
            %endfor
          </ul>
        </div>
      </div>
    </div>
</div>

<div class="subnav subnav-fixed">
    <div class="container-fluid">
      <ul class="nav nav-pills">
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">${_('Query Editors')} <b class="caret"></b></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="#">Hive</a></li>
            <li><a href="#">Impala</a></li>
            <li><a href="#">Pig</a></li>
            <li><a href="#">Job Designer</a></li>
          </ul>
        </li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#">${_('Data Browsers')} <b class="caret"></b></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="#">Metastore Tables</a></li>
            <li><a href="#">HBase</a></li>
            <li><a href="#">Sqoop Transfer</a></li>
            <li><a href="#">Zookeeper</a></li>
          </ul>
        </li>
        <li class="dropdown">
          <a class="dropdown-toggle" data-toggle="dropdown" href="#" rel="tooltip" title="Oozie">${_('Workflows')} <b class="caret"></b></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href="#">Dashboard</a></li>
            <li><a href="#">Editor</a></li>
          </ul>
        </li>
        <li>
          <a href="#" rel="tooltip" title="Solr Search" style="padding-bottom:11px">${_('Search')}</a>
        </li>
      </ul>
    </div>
  </div>

<div id="jHueNotify" class="alert hide">
    <button class="close">&times;</button>
    <span class="message"></span>
</div>

