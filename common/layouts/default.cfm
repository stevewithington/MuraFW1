<cfscript>
/**
*
* This file is part of MuraFW1
*
* Copyright 2010-2017 Stephen J. Withington, Jr.
* Licensed under the Apache License, Version v2.0
* http://www.apache.org/licenses/LICENSE-2.0
*
*/
</cfscript>
<cfoutput>
  #body#

  <script>
    Mura(function(m) { 
      m.loader() 
        .loadcss('#rc.m.globalConfig('context')#/plugins/MuraFW1/assets/css/murafw1.css') ;
    });
  </script>
</cfoutput>
