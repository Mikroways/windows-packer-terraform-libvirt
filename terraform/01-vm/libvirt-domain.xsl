<!--
    This customizes a libvirt domain xml.
    NB You can manually create a domain and them find the resulting domain xml at /etc/libvirt/qemu/*.xml.
    NB You can test this transformation with, e.g.:
        sudo xsltproc libvirt-domain.xsl /etc/libvirt/qemu/example.xml | sudo diff -u /etc/libvirt/qemu/example.xml - | vim -
    See https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/examples/v0.12/xslt/nicmodel.xsl
    See https://libvirt.org/formatdomain.html
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" omit-xml-declaration="yes" indent="yes"/>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/domain/features">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
      <!--
      Add hyper-v enlightenments
      -->
        <hyperv>
            <relaxed state='on'/>
            <vapic state='on'/>
            <spinlocks state='on' retries='8191'/>
            <vpindex state='on'/>
            <synic state='on'/>
            <stimer state='on'/>
            <reset state='on'/>
        </hyperv>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/domain/clock" />
  <xsl:template match="/domain">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
        <clock offset='utc'>
          <timer name='rtc' tickpolicy='catchup'/>
          <timer name='pit' tickpolicy='delay'/>
          <timer name='hpet' present='no'/>
          <timer name='hypervclock' present='yes'/>
        </clock>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="/domain/devices/controller[@type='usb']" />
  <xsl:template match="/domain/devices">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
      <!--
      Add spicevmc virtio-serial, sound card, 2 usb redirection channels over spicevmc
      -->
      <channel type="spicevmc">
        <target type="virtio" name="com.redhat.spice.0"/>
        <address type="virtio-serial" controller="0" bus="0" port="2"/>
      </channel>
      <sound model='ich6'>
        <alias name='sound0'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x09' function='0x0'/>
      </sound>
      <redirdev bus='usb' type='spicevmc'>
        <alias name='redir0'/>
        <address type='usb' bus='0' port='1'/>
      </redirdev>
      <redirdev bus='usb' type='spicevmc'>
        <alias name='redir1'/>
        <address type='usb' bus='0' port='2'/>
      </redirdev>
      <controller type='usb' index='0' model='qemu-xhci'>
        <alias name='usb'/>
        <address type='pci' domain='0x0000' bus='0x00' slot='0x0a' function='0x0'/>
      </controller>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
