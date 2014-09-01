<%@ page contentType="text/html;charset=UTF-8" language="java" %> 

<%@ include file="../layouts/taglib.jsp" %>
<%@ include file="../layouts/lection-resourses.jsp" %>
<%@page import="java.io.*, java.util.Date, java.util.Enumeration,java.text.DateFormat, java.text.SimpleDateFormat" %> 
<%DateFormat dateFormat = new SimpleDateFormat("MMM d, yyyy");%>
<div class="row">
    <div class="col-lg-2 sidebar">
      <ul class="lectionMeta">
      
      <li><b>Имя лекции</b></li>
      <p id="lectionName">>${lection.getLectionName()}</p>
      
      <li> <b>Дата создания:</b></li>
      <p id="lectionCreationDate">${lection.getLectionDate().getCreationDate().getTime()}</p>
      
      <li><b>Последнее изменение:</b></li>
      <p id="lectionModifiedDate">${lection.getLectionDate().getModifiedDate().getTime()}</p>
      
      <li><b>Автор:</b></li>
      <p id="lectionAuthor">${lection.getAuthor().getUserName() }</p>
      
      <li><b>Классификация:</b></li>
      <p id="lectionSubjectClassification">Математика</p>
      
      <li><b>Предмет:</b></li>
      <p id="lectionSubject">Математический анализ</p>
      
      </ul>
    <div class="btn-group">
      <button class="btn" id="convertButton">Преобразовать</button>
      <button class="btn btn-primary" data-toggle="modal" data-target="#lectionMetaModal">Изменить данные</button>
      <button class="btn btn-danger" id="saveOnServerButton">Сохранить на сервере</button>
    	
    </div>
    </div>
	  <div class="col-lg-10 main">
	    <div class="col-lg-5" id="markup-div">
	        <textarea id="lection-markup">
	        	${lection.getLectionBody()}
	        </textarea>
	    </div>
	    <div class="col-lg-5" well" id="lection-div">
	      <div id="lection">
	        <p>
	        	
	        </p>
	      </div>
	    </div>
	  </div> 
</div>

<!-- Modal -->
<div class="modal fade" id="lectionMetaModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title" id="myModalLabel">Modal title</h4>
      </div>
      
      <div class="modal-body">
			<div class="form-group">
				<label for="name" class="col-sm-2 control-label"> Имя лекции:</label>
				<div class="col-sm-10">
					<input type="text" id="lectionNameModal">
				</div>
			</div>          
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="saveLectionMetaButton" >Save changes</button>
      </div>
      
    </div>
  </div>
</div>
<script>
	$(document).ready(function(){		
		$("#saveLectionMetaButton" ).click(function() {
			$('#lectionName').empty();
			$('#lectionName').append($('#lectionNameModal').val());
			$('#lectionMetaModal').modal('hide');
		});
		
	    $("#saveOnServerButton").click(function() {
	        sendLection();
	      });
	    
	    var updateURL = '<spring:url value="/lections/update/${lection.getLectionId()}"/>'; 
	    
	    function sendLection() {
	    	console.log(getLectionJSON());
	        $.ajax({
	            contentType: 'application/json',
	            data: getLectionJSON(),
	            dataType: 'json',
	            processData: false,
	            type: 'POST',
	            url: updateURL
	        });
	      };
	      
	      function getLectionJSON() {	  
	    	  var lection = {};
	    	  lection.lectionName = $('#lectionName').html().toString();
	    	  lection.lectionCreationDate =  $('#lectionCreationDate').html().toString();
	    	  lection.lectionAuthor =  $('#lectionAuthor').html().toString();
	    	  lection.lectionBody = $('#lection-markup').val();	 
	    	  console.log(lection);
	          var lectionJSON = JSON.stringify(lection);
	          console.log(lectionJSON);
	          
	          return lectionJSON;
	        };
	    
	});
</script>