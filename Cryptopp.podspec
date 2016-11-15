Pod::Spec.new do |spec|
  spec.name = "Cryptopp"
  spec.summary = "Crypto++ Library"
  spec.homepage = 'https://github.com/cpp-ethereum-ios/cryptopp-ios'
  spec.authors = "Crypto++ Authors"
  spec.license = "Boost License"

  spec.version = "5.6.4.0"

  spec.source = {
    git: 'https://github.com/cpp-ethereum-ios/cryptopp-ios.git',
    tag: "v#{spec.version}",
    submodules: true
  }

  spec.platform = :ios
  spec.ios.deployment_target = '8.0'

  spec.prepare_command = './build-for-ios.sh'

  spec.source_files = "cryptopp/*.h"
  spec.ios.vendored_libraries = "cryptopp/libcryptopp.a"
end
