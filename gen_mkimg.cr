require "ecr"

enum DE
  GNOME
  KDE
end

NAME       = "blahaj"
VERSION    = "3.15"
VERSION_ID = "3.15.0"
VARIANT    = DE::GNOME
ANSI_COLOR = "1;96"
HOME_URL   = "os.blahaj.dev"
BUG_URL    = "github.com/blahaj-dev/os/issues"
OS_RELEASE = <<-STRING
NAME="#{NAME}"
PRETTY_NAME="#{NAME.capitalize}OS"
ID=#{NAME.downcase}
ID_LIKE=alpine
VARIANT="#{VARIANT.to_s}"
VARIANT_ID="#{VARIANT.to_s.downcase}"
VERSION_ID=#{VERSION_ID}
ANSI_COLOR="#{ANSI_COLOR}"
HOME_URL="https://#{HOME_URL}"
BUG_REPORT_URL="https://#{BUG_URL}"
STRING

USER = {
  NAME: "blahaj",
  PASS: "blahaj",
}

PACKAGES = {
  LIVE: [
    "gparted",
  ],
  BASE: [
    "nano",
    "crystal",
    "bash",
    "fish",
    "doas",
    "xorg-server",
    "xf86-input-libinput",
    "eudev",
    "mesa",
    "fish",
    "pipewire",
    "wireplumber",
    "pipewire-pulse",
    "pipewire-spa-bluez",
    "pipewire-tools",
  ],
  GNOME: [
    "gnome",
    "gnome-apps-core",
    # "gnome-apps-extra",
  ],
  KDE: [
    "plasma",
    "elogind",
    "polkit-elogind",
    "dbus",
    "sddm", # ???
  ],
}

SERVICES = {
  GNOME: [
    {"gdm" => "default"},
    {"fwupd" => "default"},
    {"networkmanager" => "default"},
  ],
  KDE: [
    {"dbus" => "default"},
    {"elogind" => "default"},
    {"polkit" => "default"},
    {"udev" => "default"},
    {"sddm" => "default"},
  ],
}

class Image
  @type : String
  @apks : String
  @name : String

  # @version : String

  def initialize(@de : DE, @description : String)
    @name = NAME
    @type = @de.to_s
    # @version = VERSION
    @apks = (PACKAGES[:LIVE] + PACKAGES[:BASE] + PACKAGES[@type]).join(" ")
  end

  ECR.def_to_s "mkimg.blahaj.sh.ecr"
end

class Genapkovl
  @type : String
  @services : String
  @apks : String
  @version : String
  @name : String
  @os_release : String
  @user : String
  @pass : String

  def initialize(@de : DE)
    @name = NAME
    @type = @de.to_s
    tmpArr = [] of String
    SERVICES[@type].each do |x|
      x.each do |y, z|
        tmpArr << "rc_add #{y} #{z}"
      end
    end
    @services = tmpArr.join("\n")
    @apks = (PACKAGES[:BASE] + PACKAGES[@type]).join("\n")
    @user = USER[:NAME]
    @pass = USER[:PASS]
    @version = VERSION
    @os_release = OS_RELEASE
  end

  ECR.def_to_s "genapkovl-blahaj.sh.ecr"
end

File.write("mkimg.blahaj.sh", Image.new(DE::GNOME, "Desktop alpine with #{DE::GNOME}").to_s)
File.write("genapkovl-blahaj.sh", Genapkovl.new(DE::GNOME).to_s)
