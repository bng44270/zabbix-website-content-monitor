define(`printurl',`$1$2')dnl
        <trigger>
            <expression>{Web Content Checks:web.test.rspcode[UNIQNAME,Homepage].last()}&lt;&gt;200 and {Web Content Checks:web.test.rspcode[UNIQNAME,Homepage].last(#3)}&lt;&gt;200</expression>
            <recovery_mode>0</recovery_mode>
            <recovery_expression/>
            <name>printurl(SITECN,URI) Content Check</name>
            <correlation_mode>0</correlation_mode>
            <correlation_tag/>
            <url/>
            <status>0</status>
            <priority>4</priority>
            <description/>
            <type>0</type>
            <manual_close>0</manual_close>
            <dependencies/>
            <tags/>
        </trigger>
