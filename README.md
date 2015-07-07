# semstats.org
Lets get on the information superhighway.

## URI Template
http://semstats.org/{id}

* {id}
  * index.html
  * {year}/index.html
  * {year}/{doc}
  * {media}
  * {scripts}

* {year}
  *	YYYY e.g., `2013`

* {doc}
  * index.html
  * {event?}call-for-workshops (used for the conference call for workshop submission)
  *	{event?}call-for-papers
  *	{event?}call-for-challenges
  *	{event?}program
  * {event?}proceedings (optional, TBD)

* {event}
  * This is optional if there are multiple workshops per year, in which case, the following applies: abbreviation of the event the workshop is part of e.g., if co-located with the "International Semantic Web Conference", use `iswc-`. For stand-alone events, use an abbreviation e.g., if the event is held at some University, use `uoa-` (for "University of Acme"). Full URL example: `http://semstats.org/2013/iswc-call-for-papers`. This pattern is not likely to happen in the forseeble future, however we document it here in any case.

* {media}
  * media/images/{file} (images for the site e.g., logo)
  * media/photos/{year}/{file} (photos from the event)
  * media/video/{year}/{file} (video recording of the event)
  * media/audio/{year}/{file} (audio recording of the event)

* {scripts}
  * scripts/{file} (scripts if needed e.g., JavaScript, XSL, Bash)

* {file}
  * filename.ext

The index.html files are used for the homepage or the landing pages for the year.
* homepage
  * a short description of the workshop
  * links to landing pages (i.e., the year) of each event e.g., `http://semstats.org/2013/`
* landing page 
  * a short description for the workshop year. This can be updated after the workshop to contain a summary of the event.
  * contains new "important" information.
  * contains an index of the documents.
  * contains contact information e.g., email, link to the conference management system, social media hashtag, or other documents/accounts elsewhere on the Web.
  * contains widgets (TBD).

Omit the `.html` extension when referring to {doc}s e.g., `http://semstats.org/2015/call-for-papers` not `http://semstats.org/2015/call-for-papers.html`. Media files should have their extensions part of the filename. Everything is lower-cased.

Announcement (e.g., mailing list) copies will be based off the original HTML. Instructions to be announced here. 
