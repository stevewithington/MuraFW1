<cfoutput><plugin>
	<name>muraFW1</name>
	<package>muraFW1</package>
	<directoryFormat>packageOnly</directoryFormat>
	<loadPriority>5</loadPriority>
	<version>2.326</version>
	<provider>Steve Withington</provider>
	<providerURL>http://stephenwithington.com</providerURL>
	<category>Application</category>
	<settings>
		<!---<setting>
			<name>Setting Name</name>
			<label>Setting Label</label>
			<hint>Setting Hint</hint>
			<type>RadioGroup</type>
			<required>false</required>
			<validation></validation>
			<regex></regex>
			<message>Setting message</message>
			<defaultvalue>1</defaultvalue>
			<optionlist>0^1</optionlist>
			<optionlabellist>No^Yes</optionlabellist>
		</setting>--->	
	</settings>
	<eventHandlers>
		<eventHandler event="onApplicationLoad" component="pluginEventHandler" persist="false" />
	</eventHandlers>
	<displayobjects location="global">
		<displayobject name="muraFW1" displaymethod="renderApp" component="pluginEventHandler" persist="false" />
	</displayobjects>
</plugin></cfoutput>