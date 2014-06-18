var methods = ["3-12-3 brainstorm", "7ps framework", "action learning", "action planning", "action research", "active listening", "activity analysis", "activity modeling", "actors map", "aeiou", "affective computing", "affinity diagram", "appreciative inquiry", "atomize", "attitude questionnaire/subjective assessment", "attribute listing", "auto-ethnography", "behavior sampling", "behavioral archaeology", "bifocal display", "blogs", "blueprint", "bodystorming", "brainstorming", "brainwriting", "canonical abstract prototyping", "card sorting", "card technique", "character profile", "checklists", "citizen advisory groups", "citizen summits", "citizen’s jury", "citizens’ panels", "classic ethnography", "close-ended questions", "co-production", "codesigning", "coding system", "cognitive maps", "cognitive walkthrough", "collaborative authoring in wikis", "communal appraisal", "community development", "community guides", "competitive product survey", "competitor analysis", "componential analysis", "concept mapping", "conjoint techniques", "consensus conference", "consensus voting", "constructive interaction", "content models", "context map", "context panorama", "context use of analysis", "context-aware computing", "contextual design", "conversation cafes", "cost-benefit analysis", "coverstory", "critical incident technique analysis", "cultural inventory", "cultural probes", "customer journey mapping", "data visualization", "day in the life", "deliberative mapping", "deliberative polling", "deliberative workshops", "delphi survey", "democs", "design charrettes", "design documentaries", "design games", "design guidelining", "design probe", "design-in-context", "diagnostic evaluation", "dialogue", "diary studies", "digital interface tv", "direct observation", "direct shell production casting", "dot voting", "dramaturgy", "dynamic faciliation", "e-petitions", "empathic design", "empathy map", "empathy probes", "empathy tool", "epanels", "error analysis", "essence finding", "ethnofuturism", "evaluate prototype", "evaluating existing system", "evidencing", "evolutionary prototyping", "expanding objectives", "experience drawing cards", "experience prototyping", "expert evaluation", "exploratory prototyping", "explore, represent, share", "extreme user interviews", "fishbowl", "flow analysis", "fly on the wall", "focus groups", "forced analogy", "forced ranking", "forum theatre", "fused deposition models", "future search", "google search", "graphic recording", "group sketching", "heuristic evaluation", "heuristic ideation technique", "history map", "identity construction", "immersive experience", "immersive workshop", "improvisation", "informance", "integration prototype", "interaction design", "interaction table", "intervention/provocation", "interviews", "issue cards", "laminated object manufacturing", "lateral thinking", "co-design", "layored elaboration", "design workshops", "lead user", "inspiration cards", "lego serious play", "library browsing", "lifelogging", "local issues forum", "longitudinal analysis", "low-fidelity prototypes", "low-tech social network", "make it real", "market segmentation", "marketing analytics", "matrix", "mediation", "mind map", "mission impossible", "mobile diary studies", "mobile probes", "mockup", "moodboard", "motivation matrix", "multi-jet modeling", "mystery shopper", "naturalistic group interview", "netnography", "new product development process", "object brainstorm", "observation and shadowing", "observational methods for service marketing", "offering map", "online consultations", "online forums", "open space technology", "open user innovation", "open-ended questions", "opinion poll", "oral histories", "participant observation", "participatory appraisal", "participatory budgeting", "participatory design game", "participatory strategic planning", "participatory video", "party groups", "passive observation", "performance ethnography", "personal inventory", "personas", "photo diaries", "photo-elicitation interview", "pictorial storytelling", "pie chart agenda", "planning cell", "planning for real", "post-up", "service poster", "powers of ten", "pre-interviews", "pre-mortem", "process analysis", "prototyping", "pseudo-documentary", "qdf-based value engineering", "quantifying focus group data", "questionnaires", "quick and dirty ethnography", "rapid ethnography", "rapid prototyping", "re-world enactments", "reflective listening", "reflective practice", "reinterview", "repertory grid technique", "requirements engineering", "role script", "role-playing", "rough prototyping", "samoan circle", "sampling", "scale modeling", "scenario", "scenario workshop", "scenario-based design", "screening", "search conference", "search for patterns", "secondary research", "see sort sketch", "serial hanging out", "service image", "service prototype", "service specification", "shadowing", "show and tell", "situated participative enactment of scenarios (spes)", "sketching", "social computing", "social enterprise", "social networking analysis", "social networking mapping", "spectrum mapping", "stakeholder analysis", "start a journal", "storyboard", "storytelling", "study circle", "surveys", "synthetics", "system map", "targeting market research", "task allocation", "task analysis", "task analysis grid", "taxonomies", "technology probe", "template", "the 4cs", "the 5 whys", "the anti-problem", "the basic questions", "the best way", "the blind side", "think-aloud protocol", "tomorrow headlines", "touchpoints matrix", "trading cards", "trial and error", "try it yourself", "twitter", "unfocus groups", "usability testing", "usage-centered design", "use cases", "user forum", "user interface prototypes", "user observation/field studies", "user panel", "video ethnography", "virtual ethnography", "virtual focus groups", "virtual immersion", "virtual worlds", "visual agenda", "visual represenation", "web forum", "webcasting", "webchat", "welcome to my world", "what others have done", "whodo", "wiki", "wizard of oz", "work analysis", "world cafe", "write down all you know", "written consultations", "zaltman metaphor elicitation technique (zmet)", "silk method deck (social innovation lab for kent)", "social circles", "modeling", "talk aloud protocol"];
var caseStudyAtrributes = "https://docs.google.com/spreadsheet/pub?key=0AjAwCuCEhsj_dEZuM2ROU3VjUV9sTWs4TWZDTnotTkE&output=html";
function getURLParameters(paramName) 
{
        var sURL = window.document.URL.toString();  
    if (sURL.indexOf("?") > 0)
    {
       var arrParams = sURL.split("?");         
       var arrURLParams = arrParams[1].split("&");      
       var arrParamNames = new Array(arrURLParams.length);
       var arrParamValues = new Array(arrURLParams.length);     
       var i = 0;
       for (i=0;i<arrURLParams.length;i++)
       {
        var sParam =  arrURLParams[i].split("=");
        arrParamNames[i] = sParam[0];
        if (sParam[1] != "")
            arrParamValues[i] = unescape(sParam[1]);
        else
            arrParamValues[i] = "No Value";
       }

       for (i=0;i<arrURLParams.length;i++)
       {
                if(arrParamNames[i] == paramName){
            //alert("Param:"+arrParamValues[i]);
                return arrParamValues[i];
             }
       }
       return "No Parameters Found";
    }
}

Object.size = function(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
};

String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}