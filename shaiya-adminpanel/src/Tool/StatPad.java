/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Tool;

import SQL.Conexao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Jorgi Luiz Bolonhezi Dias
 */
 
public class StatPad extends javax.swing.JFrame {

    /**
     * Creates new form StatPad
     */
    public StatPad() {
        initComponents();
        setSize(750, 309);
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

        Search = new javax.swing.JButton();
        Menu = new javax.swing.JButton();
        jScrollPane1 = new javax.swing.JScrollPane();
        StatPad = new javax.swing.JTextArea();
        jFundo = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Stat Padders - Panel");
        setResizable(false);
        getContentPane().setLayout(null);

        Search.setBackground(new java.awt.Color(0, 51, 102));
        Search.setForeground(new java.awt.Color(255, 255, 255));
        Search.setText("Search");
        Search.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                SearchActionPerformed(evt);
            }
        });
        getContentPane().add(Search);
        Search.setBounds(410, 10, 110, 23);

        Menu.setBackground(new java.awt.Color(0, 51, 102));
        Menu.setForeground(new java.awt.Color(255, 255, 255));
        Menu.setText("Menu");
        Menu.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                MenuActionPerformed(evt);
            }
        });
        getContentPane().add(Menu);
        Menu.setBounds(410, 50, 110, 23);

        StatPad.setColumns(20);
        StatPad.setRows(5);
        jScrollPane1.setViewportView(StatPad);

        getContentPane().add(jScrollPane1);
        jScrollPane1.setBounds(350, 110, 180, 96);

        jFundo.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Images/LionNews.jpg"))); // NOI18N
        getContentPane().add(jFundo);
        jFundo.setBounds(0, 0, 744, 282);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void MenuActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_MenuActionPerformed
            new JBLogin().setVisible(true);
            this.dispose();
            this.setResizable(false);
    }//GEN-LAST:event_MenuActionPerformed

    private void SearchActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_SearchActionPerformed
        try{        
                Conexao con = new Conexao();
                String SQL = "SELECT * FROM PS_GameData.dbo.Chars WHERE K2>0 and K1<1";
                PreparedStatement ps = con.getConexao().prepareStatement(SQL);
                ResultSet registros = ps.executeQuery();
                registros.next();
                String Am = registros.getString("CharName");
                if(Am!=null){
                    StatPad.setText("Possible Stat Padders Found: "+Am);
                }else{
                    StatPad.setText("No Stat Padders!");
                }
        } catch (Exception e) {
            StatPad.setText("Error:"+e);
        }
    }//GEN-LAST:event_SearchActionPerformed

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
            java.util.logging.Logger.getLogger(StatPad.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(StatPad.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(StatPad.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(StatPad.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new StatPad().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton Menu;
    private javax.swing.JButton Search;
    private javax.swing.JTextArea StatPad;
    private javax.swing.JLabel jFundo;
    private javax.swing.JScrollPane jScrollPane1;
    // End of variables declaration//GEN-END:variables
}
