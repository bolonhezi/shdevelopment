/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Tool;

import SQL.Conexao;
import SQL.EnviarData;
import Send.Enviar;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import javax.swing.JOptionPane;

/**
 *
 * @author Jorgi Luiz Bolonhezi Dias
 */
 
public class SItem extends javax.swing.JFrame {

    /**
     * Creates new form SItem
     */
    Enviar obj;

    public SItem() {
        initComponents();
        setSize(750, 310);
        setLocationRelativeTo(null);
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        ItemID = new javax.swing.JTextField();
        Slot = new javax.swing.JTextField();
        Quantity = new javax.swing.JTextField();
        UserUID = new javax.swing.JTextField();
        jResponsavel = new javax.swing.JTextField();
        jButton1 = new javax.swing.JButton();
        jButton2 = new javax.swing.JButton();
        jFundo = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Send Item - Panel");
        setResizable(false);
        getContentPane().setLayout(null);

        jLabel1.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(255, 255, 255));
        jLabel1.setText("Item ID:");
        getContentPane().add(jLabel1);
        jLabel1.setBounds(370, 10, 70, 30);

        jLabel2.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel2.setForeground(new java.awt.Color(255, 255, 255));
        jLabel2.setText("Slot:");
        getContentPane().add(jLabel2);
        jLabel2.setBounds(400, 50, 40, 30);

        jLabel3.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel3.setForeground(new java.awt.Color(255, 255, 255));
        jLabel3.setText("Quantity:");
        getContentPane().add(jLabel3);
        jLabel3.setBounds(370, 90, 70, 30);

        jLabel4.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel4.setForeground(new java.awt.Color(255, 255, 255));
        jLabel4.setText("User UID:");
        getContentPane().add(jLabel4);
        jLabel4.setBounds(370, 130, 67, 30);

        jLabel5.setFont(new java.awt.Font("Tahoma", 1, 14)); // NOI18N
        jLabel5.setForeground(new java.awt.Color(255, 255, 255));
        jLabel5.setText("Responsible:");
        getContentPane().add(jLabel5);
        jLabel5.setBounds(410, 170, 87, 30);
        getContentPane().add(ItemID);
        ItemID.setBounds(440, 10, 90, 30);
        getContentPane().add(Slot);
        Slot.setBounds(440, 50, 90, 30);
        getContentPane().add(Quantity);
        Quantity.setBounds(440, 90, 90, 30);
        getContentPane().add(UserUID);
        UserUID.setBounds(440, 130, 90, 30);

        jResponsavel.setToolTipText("");
        getContentPane().add(jResponsavel);
        jResponsavel.setBounds(500, 170, 150, 30);

        jButton1.setBackground(new java.awt.Color(0, 51, 102));
        jButton1.setForeground(new java.awt.Color(255, 255, 255));
        jButton1.setText("Send");
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });
        getContentPane().add(jButton1);
        jButton1.setBounds(660, 10, 57, 23);

        jButton2.setBackground(new java.awt.Color(0, 51, 102));
        jButton2.setForeground(new java.awt.Color(255, 255, 255));
        jButton2.setText("Menu");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });
        getContentPane().add(jButton2);
        jButton2.setBounds(660, 50, 59, 23);

        jFundo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Images/LionNews.jpg"))); // NOI18N
        getContentPane().add(jFundo);
        jFundo.setBounds(0, 0, 744, 282);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
        new JBLogin().setVisible(true);
        this.dispose();
        this.setResizable(false);
    }//GEN-LAST:event_jButton2ActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        try {
            if (ValidarCampos()) {
                if (preencherObjeto()) {
                    EnviarData DAO = new EnviarData();
                    if (DAO.incluir(obj)) {
                        JOptionPane.showMessageDialog(null, "Item enviado com Sucesso.");
                        String data = "dd/MM/yyyy";
                        String hora = "h:mm - a";
                        String data1, hora1;
                        java.util.Date agora = new java.util.Date();;
                        SimpleDateFormat formata = new SimpleDateFormat(data);
                        data1 = formata.format(agora);
                        formata = new SimpleDateFormat(hora);
                        hora1 = formata.format(agora);
                        Conexao con1 = new Conexao();
                        String SQL1 = "INSERT INTO PS_ActionPerformed.dbo.Action values(?,'Ban Account',?,?,?)";
                        PreparedStatement ps1 = con1.getConexao().prepareStatement(SQL1);
                        ps1.setString(1, jResponsavel.getText());
                        ps1.setString(2, data1);
                        ps1.setString(3, hora1);
                        ps1.setString(4, jResponsavel.getText());
                        int registros1 = ps1.executeUpdate();
                        ItemID.setText("");
                        Quantity.setText("");
                        Slot.setText("");
                        UserUID.setText("");
                        jResponsavel.setText("");
                    } else {
                        JOptionPane.showMessageDialog(this, "Não foi Possivel enviar o Item");
                    }
                }
            }
        } catch (Exception erro) {
            JOptionPane.showMessageDialog(this, "Erro: " + erro.getMessage());
        }
    }//GEN-LAST:event_jButton1ActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(SItem.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(SItem.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(SItem.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(SItem.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new SItem().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextField ItemID;
    private javax.swing.JTextField Quantity;
    private javax.swing.JTextField Slot;
    private javax.swing.JTextField UserUID;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JLabel jFundo;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JTextField jResponsavel;
    // End of variables declaration//GEN-END:variables
private boolean ValidarCampos() {
        if (ItemID.getText().equals("")) {
            JOptionPane.showMessageDialog(this, "Digite o ID do Item");
            ItemID.requestFocus();
            return false;
        }
        if (Quantity.getText().equals("")) {
            JOptionPane.showMessageDialog(this, "Digite a Quantidade");
            Quantity.requestFocus();
            return false;
        }
        if (Slot.getText().equals("")) {
            JOptionPane.showMessageDialog(this, "Digite o Slot");
            Slot.requestFocus();
            return false;
        }
        if (UserUID.getText().equals("")) {
            JOptionPane.showMessageDialog(this, "Digite o UserUID");
            UserUID.requestFocus();
            return false;
        }
        if (jResponsavel.getText().equals("")) {
            JOptionPane.showMessageDialog(this, "Digite o seu Nome");
            jResponsavel.requestFocus();
            return false;
        }
        return true;
    }

    private boolean preencherObjeto() throws Exception {
        obj = new Enviar();
        obj.setItemID(ItemID.getText());
        obj.setQuantidade(Quantity.getText());
        obj.setSlot(Slot.getText());
        obj.setUserUID(UserUID.getText());
        return true;
    }

}
