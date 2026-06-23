local this = {}
function this.write(textbox:TextLabel,text:string)
	textbox.Text=""
	for i=1,#text do
		textbox.Text=textbox.ContentText..text:sub(i,i)
		wait(0.03)
	end
end
return this
