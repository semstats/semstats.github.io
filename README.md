# semstats.org
Lets get on the information superhighway.

Below is only really interesting for SemStats OC/admin.

## URI Template
http://semstats.org/{id}

* {id}
  * index.html
  * {year}/index.html
  * {year}/{doc}
  * {year}/{content}
  * {year}/{challenge}
  * {media}
  * {scripts}

* {year}
  * YYYY e.g., `2013`

* {doc}
  * index.html
  * {event?}call-for-workshops (used for the conference call for workshop submission)
  * {event?}call-for-contributions
  * {event?}call-for-challenges
  * {event?}program
  * {event?}proceedings (optional, usually the copy that's submitted to CEUR-WS)

* {content}
  * {article}/* (all the work's material which may coincide with the CEUR-WS submission)

* {event}
  * This is optional if there are multiple workshops per year, in which case, the following applies: abbreviation of the event the workshop is part of e.g., if co-located with the "International Semantic Web Conference", use `iswc-`. For stand-alone events, use an abbreviation e.g., if the event is held at some University, use `uoa-` (for "University of Acme"). Full URL example: `http://semstats.org/2013/iswc-call-for-papers`. This pattern is not likely to happen in the forseeble future, however we document it here in any case.

* {article}
  * Path to the article (using the article's title). The naming convention is loosely a string with dashes in place of non-alphanumerics e.g., linked-statistical-data-analysis

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

Where possible, use the canonical hyperlink of external media files instead of a local copy.

## How to generate the proceedings
This is one of the processes we can use to generate the proceedings. I broke it down as close as possible; it is manual, but simple enough. If you prefer otherwise, see ceur-make for the alternative methods. We should let the authors retain the complete copyright.

The procedure below will create a proceeding with individual papers (i.e., not an "all-in-one PDF" as mention in ceur-make); which means that when you create toc.xml don't use the pages information per paper e.g., `<pages from="2" to="6"/>`. There is no need to get the proceedings volume number in advance unless you really want to. That number will be mentioned in workshop.xml. See 2014/proceedings/ceur/ in this repository for a complete example of inputs and outputs. See also http://ceur-ws.org/HOWTOSUBMIT.html

* `git clone https://github.com/ceurws/ceur-make`
* `mkdir -p 20XX/proceedings/ceur/ceur-ws/` (enter year)
* `cd ceur-make`
* `./ceur-make-init ../semstats.github.io/20XX/proceedings/ceur` (enter year)
* `cd ../semstats.github.io/20XX/proceedings/ceur`
* Create `toc.xml` and `workshop.xml`. See ceur-make documentation for further instruction and best practice. For the papers listed in toc.xml, use the order as in the workshop program. For workshop.xml, stay consistent, i.e., change only variable information (conference, editors..)
* `cp Makefile.vars.template Makefile.vars`
* `nano Makefile.vars` (Make sure path to XSLT processor is right e.g., I used `java -cp /usr/share/java/saxonb.jar net.sf.saxon.Transform` on Ubuntu. Other than the variables `SHELL` and `SAXON`, everything else is commented out).
* `make ceur-ws/index.html`
* `firefox ceur-ws/index.html` (See how it looks). Update index.html with additional information with care (e.g., RDFa).
* Note that the URLs to papers in the index.html follow the pattern: `paper-XX.pdf` (where XX is a number starting from 01). Place the files in the same directory as index.html (e.g., 2014/proceedings/ceur/ceur-ws/).
* `make zip` . This should generate `SemStats-20XX.zip` and `ceur-ws/temp.bib`.
* `cp ceur-ws/temp.bib ceur-ws/SemStats-20XX.bib` (enter year) and `make zip` again. This will now include `SemStats-20XX.bib` in the zip.
* Commit and push all your changes back to this repository: `git add 20XX && git commit -m "CEUR Proceedings for SemStats20XX." && git push`
