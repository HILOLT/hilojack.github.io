---
layout: default
---
<script>
    window.onload=function(){
        var className='prettyprint';
        var pres = document.getElementsByTagName('pre');
        if(pres.length >0){
            for(i =0;i<pres.length;i++ ){
                pres[i].classList.add(className); 
            } 
        }
    }
</script>
<div class="post">

  <header class="post-header">
      <div>
          <div class="post-title">
              {{ page.title }} <br/>       
          </div>
          <span class="post-date" >{{ page.date | date: "%b %-d, %Y" }}</span>
      </div>
  </header>

  <article class="post-content">
  {{ content }}
  </article>

</div>
<hr/>

<div id="disqus_thread"></div>
<script type="text/javascript">
    /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
    var disqus_shortname = 'hilojack'; // required: replace example with your forum shortname

    /* * * DON'T EDIT BELOW THIS LINE * * */
    (function() {
        var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
        dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
        (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
    })();
</script>
<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
<a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>
<hr/>

<div class="post-page"> 
    <div class="post-page-left">
        <a href="{{ page.previous.url }}">{{ page.previous.title }}</a>
    </div>
    <div class="post-page-right">
        <a href="{{ page.next.url }}">{{ page.next.title }}</a>
    </div>
</div>
