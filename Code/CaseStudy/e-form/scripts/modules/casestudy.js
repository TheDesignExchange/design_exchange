
var info = {
      "1": {
        "username": "Aaron", 
        "title" : "A Case Study of Non-User-Centered Design for a Police Emergency-Response System", 
        "domain": ["interaction design", "research"], 
        "url": "http://www.amanda.com/joomla_uploads/whitepapers/Intrxns.SJPD.Art.pp12ff.120906%282%29.pdf", 
        "authors": "Aaron Marcus, Jim Gasperini", "company" : "Aaron Marcus and Associates", 
        "description": "Evaluate the software: The government had been spent more than $4 million  on the software, and it was performing poorly, with many usability problems.",
        "methods" : ["User-centered design"], 
        "characterization": {
          "development-cycle": "Product Update",
          "design-cycle": "Conceptual Design",
          "customer-type": "Consumer",
          "privacy-level": "Public",
        }
      }, 
      "2":{"username": "Yipu", "description": "The mall.", "methods" : ["Brainstorm", "Ideate", "Interview"]},
      "3":{"username": "Cesar", "description": "Goats"},
      "4":{"username": "S", "description" : 'Movies'}
}

var options = {
    "characterization": {
          "development-cycle": ["Product Update", "Product Refinement", "New Product", "None of these"],
          "design-cycle": ["Conceptual Design", "Problem Assessment", "Detailed design", "None of these"],
          "customer-type": ["Consumer", "Government", "Educational Group", "Business", "NGO", "None of these"],
          "privacy-level": ["Private", "Public", "Both", "None of these"]
    }
}

var activeStudy;
var casestudies = [];
// CSid, infoNode, # of case studies that person person has to go through
function CaseStudy(id, node, n){
  this.id = id;
  this.n = n;
  

  // var cs = new CaseStudy(1, info[1], 4)

  for(var prop in node)
    this[prop] = node[prop];

  // cs.methods ---> ["User-centered design"]
  // cs.domain ---> ["interaction design", "research"]
}






