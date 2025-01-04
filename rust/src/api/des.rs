use des::cipher::generic_array::GenericArray;
use des::cipher::{BlockDecrypt, BlockEncrypt, KeyInit};
use des::Des;

pub fn des_encrypt(data: &[u8], key: &[u8]) -> String {
    assert_eq!(key.len(), 8, "DES key must be 8 bytes long");

    let key = GenericArray::from_slice(key);
    let mut encryptor = Des::new(&key);
    let padded_data = pad_data(data, 8);

    let mut encrypted_data = Vec::with_capacity(padded_data.len());
    for chunk in padded_data.chunks(8) {
        let mut block = GenericArray::clone_from_slice(chunk);
        encryptor.encrypt_block(&mut block);
        encrypted_data.extend_from_slice(&block);
    }

    base64::encode(&encrypted_data)
}

pub fn des_decrypt(encrypted_base64: &str, key: &[u8]) -> Vec<u8> {
    assert_eq!(key.len(), 8, "DES key must be 8 bytes long");

    let encrypted_data = base64::decode(encrypted_base64).expect("Base64 decode failed");

    let key = GenericArray::from_slice(key);
    let mut decryptor = Des::new(&key);

    let mut decrypted_data = Vec::with_capacity(encrypted_data.len());
    for chunk in encrypted_data.chunks(8) {
        let mut block = GenericArray::clone_from_slice(chunk);
        decryptor.decrypt_block(&mut block);
        decrypted_data.extend_from_slice(&block);
    }

    if let Some(&last_byte) = decrypted_data.last() {
        let padding_length = last_byte as usize;
        decrypted_data.truncate(decrypted_data.len() - padding_length);
    }

    decrypted_data
}

fn pad_data(data: &[u8], block_size: usize) -> Vec<u8> {
    let padding = block_size - (data.len() % block_size);
    let mut padded_data = data.to_vec();
    padded_data.extend(std::iter::repeat(padding as u8).take(padding));
    padded_data
}
