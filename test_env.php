<?php
echo "PHP OK ✅ | Dossier site: ".(is_dir("/var/www/html/techsolutions")?"✅":"❌")."<br>";
echo "MySQLi extension: ".(extension_loaded("mysqli")?"✅":"❌");
?>
