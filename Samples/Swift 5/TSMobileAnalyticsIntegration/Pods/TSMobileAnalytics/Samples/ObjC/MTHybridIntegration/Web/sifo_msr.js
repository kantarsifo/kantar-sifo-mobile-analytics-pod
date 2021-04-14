function sifo_setdxmsr(value) {
    var cn = "sifo_msr";
    try {
        if (!localStorage.getItem(cn)) {
            localStorage.setItem(cn, value)
        }
    } catch (e) {}
    var date = new Date();
    date.setTime(date.getTime() + (730 * 24 * 60 * 60 * 1000));
    var expires = "; expires=" + date.toGMTString();
    var dprts = new String(document.domain).split(".");
    dprts.reverse();
    var dom = '.' + dprts[1] + '.' + dprts[0];
    document.cookie = cn + "=" + value + expires + "; path=/; domain=" + dom
}
function sifo_getdxmsr() {
    var cn = "sifo_msr";
    var found = 0;
    var ret = 0;
    try {
        if (localStorage.getItem(cn)) {
            ret = localStorage.getItem(cn);
            found = 1
        }
    } catch (e) {}
    if (!found) {
        if (document.cookie.length > 0) {
            ret = sifo_getCookieValue(cn);
            if (ret) sifo_setdxmsr(ret)
        }
    }
    return ret
}

// this fixes an issue with the old method, ambiguous values
// with this test document.cookie.indexOf( name + "=" );
function getCookie( check_name ) {
	// first we'll split this cookie up into name/value pairs
	// note: document.cookie only returns name=value, not the other components
	var a_all_cookies = document.cookie.split( ';' );
	var a_temp_cookie = '';
	var cookie_name = '';
	var cookie_value = '';
	var b_cookie_found = false; // set boolean t/f default f

	for ( i = 0; i < a_all_cookies.length; i++ )
	{
		// now we'll split apart each name=value pair
		a_temp_cookie = a_all_cookies[i].split( '=' );


		// and trim left/right whitespace while we're at it
		cookie_name = a_temp_cookie[0].replace(/^\s+|\s+$/g, '');

		// if the extracted name matches passed check_name
		if ( cookie_name == check_name )
		{
			b_cookie_found = true;
			// we need to handle case where cookie has no value but exists (no = sign, that is):
			if ( a_temp_cookie.length > 1 )
			{
				cookie_value = unescape( a_temp_cookie[1].replace(/^\s+|\s+$/g, '') );
			}
			// note that in cases where cookie is initialized but no value, null is returned
			return cookie_value;
			break;
		}
		a_temp_cookie = null;
		cookie_name = '';
	}
	if ( !b_cookie_found )
	{
		return null;
	}
}

function sifo_getCookieValue(cn) {
    c_start = document.cookie.indexOf(cn + "=");
    if (c_start != -1) {
        c_start = c_start + cn.length + 1;
        c_end = document.cookie.indexOf(";", c_start);
        if (c_end == -1) c_end = document.cookie.length;
        return document.cookie.substring(c_start, c_end)
    }
    return false
}
