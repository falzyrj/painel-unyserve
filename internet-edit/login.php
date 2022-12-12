<?php
include_once("functions.php");
?>
<!DOCTYPE html>
<html lang="pt-br" class="body-full-height">
    <head>     
           
        <!-- META SECTION -->
        <title>Painel de controle - Painel4G</title>            
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="favicon.ico" type="image/x-icon" />
        <!-- END META SECTION -->
        <!-- CSS INCLUDE -->        
        <link rel="stylesheet" type="text/css" id="theme" href="css/theme-night.css"/>
        <link rel="stylesheet" type="text/css" id="theme" href="css/background.css"/>
        <!-- EOF CSS INCLUDE -->                                     
    </head>
    
    <body class="vertical-layout vertical-menu-modern blank-page navbar-floating footer-static  " data-open="click" data-menu="vertical-menu-modern" data-col="blank-page">

<!-- BACKGROUND ANIMADO #INICIO -->
<div class="area" >
            <ul class="circles">
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li></li>
            </ul>
			
    <!-- BEGIN: Content-->
        
        <div class="login-container">
            <div class="login-box animated fadeInDown">
                <div class="login-logo">Painel Uny serve</div>
				<div class="login-legenda">Controle de Acessos, apenas acesso autorizado</div>
                <div class="login-body">
                <marquee behavior="scroll" onmouseout="this.start();" onmouseover="this.stop();"><b>📣<font color="#ffffff">Use seu painel com sabedoria, o uso incorreto, resultara em banimento do servidor.</b></font></marquee>
                    <div class="login-title"><strong>&#160;&#160;&#160;Bem-vindo(a)</strong>, Digite seus dados</div>
                    <form id="FormLogin" name="FormLogin" class="form-horizontal" method="POST" action="javascript:FormLogin()">
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="text" name="usuario" class="form-control" placeholder="Usuário"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-12">
                            <input type="password" name="senha" class="form-control" placeholder="Senha"/>
                        </div>
                    </div>
                    <div class="form-group">
                   	    <div id="StatusLogin"></div>
                    	<div class="col-md-12">
                            <button class="btn btn-info btn-block">Acessa Painel</button>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
            
        </div>

<script type="text/javascript" src="js/plugins/jquery/jquery.min.js"></script>
<script>
$(function(){

	$("#FormLogin").submit(function() {
		
		var formData = new FormData($(this)[0]);

		$.ajax({
			
			type: "POST",
			data: formData,
			async: true,
			url: "validar-login.php",
			success: function(result){
				$("#StatusLogin").html('');
				$("#StatusGeral").html('');
				$("#StatusGeral").append(result);
			},
			beforeSend: function(){
		  	  	$('#StatusLogin').html("<center><img src=\"img/owl/AjaxLoader.gif\"><br><br></center>");
		  	},
			cache: false,
        	contentType: false,
        	processData: false
	 	});
	});
});
</script>

<div id="StatusGeral"></div>
    </body>
    
</html>



