var myInterval

function read(content, myLabel, text){

	window.clearInterval(myInterval);
	
	if(!content==""){


	randIndex = Math.round((content.response.docs.length-1) * Math.random(),0)

        readMe = content.response.docs[randIndex].highlight + " --  -- -- " + content.response.docs[0].author + " -----  ----- ----- ----- -----"

        var speedytext = readMe.split(" ");

        length = speedytext.length;
        counter = 0;
        timer = 200; // a word will appear at this number of milliseconds
        myInterval = setInterval(function()
        {
                if (counter < length)
                {
                        myLabel.html(speedytext[counter])
                        counter++
			if (counter>=length){
				counter = 0
			
				randIndex = Math.round((content.response.docs.length-1) * Math.random(),0)
				
				readMe = content.response.docs[randIndex].highlight + " --  --  -- " + content.response.docs[randIndex].author + " -----  -----  -----  -----  -----"
			        
				speedytext = readMe.split(" ");
			}
                }
        },timer);

        // some stats
        stats = 1000 / timer;
        wpm = Math.round(stats * 60,0);
        time = wpm / length;

        $("#stats").html("Reading " + length + " words at " + wpm + " per minute");


	}else{
		//one liner to pull the searchterm from the request
		myLabel.html(text);
	}
}
	

